// https://observablehq.com/framework/config

import { Database } from "duckdb-async";


const db = await Database.create(":memory:");
const rows = await db.all(`
  select
    distinct(provider_id)
  from read_parquet('https://data.filecoindataportal.xyz/filecoin_storage_providers.parquet')
  where total_active_deals > 0
`);

const providerPaths = rows.map(row => `/provider/${row.provider_id}`);

export default {
  title: "Filecoin Storage Providers Market",
  head: '<link rel="icon" href="logo.png" type="image/png" sizes="32x32">',
  root: "src",
  theme: [
    "parchment",
    "alt"
  ],
  footer: false,
  sidebar: false,
  toc: false,
  pager: false,
  dynamicPaths: providerPaths
};
