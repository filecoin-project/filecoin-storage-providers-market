#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
  SELECT
    *
  FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_storage_providers.parquet')
) TO STDOUT (FORMAT 'CSV');
EOF
