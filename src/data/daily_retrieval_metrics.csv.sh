
#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
    with retrieval_rates as (
    select
        date,
        provider_id,
        case
        when total_retrieval_requests > 0
        then successful_retrieval_requests * 1.0 / total_retrieval_requests
        else 0
        end as retrieval_rate
    from read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_storage_providers_metrics.parquet')
    where date >= current_date() - interval '90 days'
    )

    select
    date,
    count(distinct provider_id) as meet_retrieval_sli,
    count(distinct provider_id) * 1.0 / (
        select count(distinct provider_id)
        from retrieval_rates
        where date = r.date
    ) as meet_retrieval_sli_percent
    from retrieval_rates r
    where retrieval_rate > 0.9
    group by date
    order by date desc
) TO STDOUT (FORMAT 'CSV');
EOF
