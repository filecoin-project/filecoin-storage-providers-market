#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
  SELECT
    date,
    unique_deal_making_providers,
    providers_with_active_deals,
    providers_with_power,
  FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_metrics.parquet')
) TO STDOUT (FORMAT 'CSV');
EOF
