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
        quality_adjusted_power_pibs
      FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_storage_providers_metrics.parquet')
      WHERE date >= CURRENT_DATE() - INTERVAL '30 days'
      ORDER BY date desc
    ) TO '$TMPDIR/storage_providers_metrics.parquet' (FORMAT 'PARQUET');
EOF
fi

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
  SELECT
    date,
    provider_id,
    onboarded_data_tibs,
    deals,
    raw_power_pibs,
    quality_adjusted_power_pibs
  FROM '$TMPDIR/storage_providers_metrics.parquet'
  WHERE provider_id = '${provider}'
  ORDER BY date desc
) TO STDOUT (FORMAT 'CSV');
EOF
