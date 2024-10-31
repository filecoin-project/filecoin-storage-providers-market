#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (

  WITH interesting_providers AS (
    SELECT
      distinct(provider_id)
    FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_storage_providers.parquet')
    WHERE total_active_deals > 0
  )

  SELECT
    date,
    provider_id,
    onboarded_data_tibs,
    deals,
    raw_power_pibs,
    quality_adjusted_power_pibs
  FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_storage_providers_metrics.parquet')
  WHERE 1=1
    AND date >= CURRENT_DATE() - INTERVAL '90 days'
    AND provider_id IN (SELECT provider_id FROM interesting_providers)
  ORDER BY provider_id desc, date desc

) TO STDOUT (FORMAT 'PARQUET', COMPRESSION 'ZSTD');
EOF
