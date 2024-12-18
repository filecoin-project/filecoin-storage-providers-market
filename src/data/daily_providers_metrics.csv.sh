
#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
    with base as (
        select
            date,
            provider_id,
            spark_retrieval_success_rate,
            sector_health_rate,
        from read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_storage_providers_metrics.parquet')
    where date >= current_date() - interval '90 days'
    )

    select
        date,
        count(distinct provider_id) filter (where spark_retrieval_success_rate >= 0.90) as meet_retrieval_slo,
        count(distinct provider_id) filter (where sector_health_rate between 0.95 and 1.00) as meet_sector_health_sli,
    from base
    group by date
    order by date desc
) TO STDOUT (FORMAT 'CSV');
EOF
