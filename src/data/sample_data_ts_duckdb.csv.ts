import { Database } from "duckdb-async";


const db = await Database.create(":memory:");
const rows = await db.all(`
    SELECT
        cast(date as string) as date,
        unique_deal_making_providers,
        providers_with_active_deals,
        providers_with_power,
    FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_metrics.parquet')
    WHERE date >= CURRENT_DATE() - INTERVAL '90 days'
`);

// Convert rows to CSV format
const headers = Object.keys(rows[0]).join(',');
const csvRows = rows.map(row => Object.values(row).join(','));
const csvContent = [headers, ...csvRows].join('\n');

// Write to stdout
console.log(csvContent);
