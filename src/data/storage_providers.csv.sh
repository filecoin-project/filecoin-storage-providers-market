#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
  with daily_sp_metrics_base as (
      select
          date,
          provider_id,
          spark_retrieval_success_rate,
          sector_health_rate,
      from read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_storage_providers_metrics.parquet')
  where date >= current_date() - interval '90 days'
  ),

  daily_sp_metrics as (
    select
        provider_id,
        count(date) filter (where spark_retrieval_success_rate > 0.90) as days_meet_retrieval_slo,
        count(date) filter (where sector_health_rate between 0.95 and 1.00) as days_meet_sector_health_slo,
        count(date) filter (where spark_retrieval_success_rate > 0.90 and sector_health_rate between 0.95 and 1.00) as days_meet_both_slos,
        round(cast(count(date) filter (where spark_retrieval_success_rate > 0.90 and sector_health_rate between 0.95 and 1.00) as double) / count(date), 3) as proportion_days_meet_both_slos
    from daily_sp_metrics_base
    group by provider_id
  )

  SELECT
    sp.provider_id,
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
    capacity_utilization_ratio,
    days_meet_retrieval_slo,
    days_meet_sector_health_slo,
    days_meet_both_slos,
    proportion_days_meet_both_slos
  FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_storage_providers.parquet') as sp
  left join daily_sp_metrics as dsp on sp.provider_id = dsp.provider_id
  WHERE sp.total_active_deals > 0
) TO STDOUT (FORMAT 'CSV');
EOF
