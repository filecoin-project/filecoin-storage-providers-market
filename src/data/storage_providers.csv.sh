#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
  SELECT
    provider_id,
    total_active_deals,
    total_active_data_uploaded_tibs,
    total_active_unique_clients,
    first_deal_at,
    last_deal_at,
    raw_power_pibs,
    quality_adjusted_power_pibs,
    balance,
    initial_pledge,
    locked_funds,
    provider_collateral,
    capacity_utilization_ratio
  FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_storage_providers.parquet')
  WHERE total_active_deals > 0
) TO STDOUT (FORMAT 'CSV');
EOF
