#!/usr/bin/env bash

# Read the provider ID from the command line argument
provider=$(echo "$@" | grep -oP '(?<=--provider=)[^ ]+')

# Use the data loader cache directory to store the downloaded data.
TMPDIR="src/.observablehq/cache"

if [ ! -f "$TMPDIR/storage_providers_metrics.parquet" ]; then
  duckdb :memory: << EOF
    SET enable_progress_bar = false;
    COPY (
      SELECT
        date,
        provider_id,
        onboarded_data_tibs,
        deals,
        raw_power_pibs,
        quality_adjusted_power_pibs,

        -- Spark Retrieval Metrics
        total_retrieval_requests,
        successful_retrieval_requests,

        -- Sector Events
        sector_added_events_count,
        sector_faulted_events_count,

        -- Sector Health
        active_sectors,
        sector_health_rate * 100 as sector_health_rate,
      FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_storage_providers_metrics.parquet')
      WHERE date >= CURRENT_DATE() - INTERVAL '90 days'
      ORDER BY date desc
    ) TO '$TMPDIR/storage_providers_metrics.parquet' (FORMAT 'PARQUET');
EOF
fi

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
  SELECT
    *
  FROM '$TMPDIR/storage_providers_metrics.parquet'
  WHERE provider_id = '${provider}'
  ORDER BY date desc
) TO STDOUT (FORMAT 'CSV');
EOF
