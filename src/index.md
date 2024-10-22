# Filecoin Storage Providers Market

Get visibility into the market between Storage Clients and Storage Providers. The goal is to help Storage Clients find potential Storage Providers, and to help Storage Providers understand how they are evaluated and compared.

- Learn more about the [metrics](metrics).
- Check the [code](https://github.com/davidgasquez/filecoin-storage-providers-market).

```js
const daily_metrics = FileAttachment("data/daily_metrics.csv").csv({typed: true});
```

## Metrics

<div class="grid grid-cols-3">

  <div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Deal Making Providers",
    subtitle: "How many providers are making deals.",
    x: {label: "Date"},
    y: {grid: true, label: "Providers"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(daily_metrics, {
        x: "date",
        y: "unique_deal_making_providers",
        tip: true
      })
    ]
  }))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Providers With Active Deals",
    subtitle: "How many providers have active deals.",
    x: { label: "Date" },
    y: { grid: true, label: "Providers", zero: true },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(daily_metrics, {
        x: "date",
        y: "providers_with_active_deals",
        tip: true
      })
    ]
  }))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Providers With Power",
    subtitle: "How many providers are with power.",
    x: { label: "Date" },
    y: { grid: true, label: "Providers", zero: true },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(daily_metrics, {
        x: "date",
        y: "providers_with_power",
        tip: true
      })
    ]
  }))
  ```

  </div>
</div>

<div class="grid grid-cols-2">
  <div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Hot Service Conformance",
    subtitle: "Percentage of providers conforming to hot SLO standards",
    x: { label: "Date" },
    y: {
      grid: true,
      label: "Conformance (%)",
      domain: [0, 100]
    },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.ruleY([80]),
      Plot.text(
        ["To be implemented"],
        {
          x: 0,
          y: 40,
          fontSize: 48,
          fill: "var(--theme-foreground-faint)"
        }
      )
    ]
  }))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Archive Service Conformance",
    subtitle: "Percentage of providers conforming to archive SLO standards",
    x: { label: "Date" },
    y: {
      grid: true,
      label: "Conformance (%)",
      domain: [0, 100]
    },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.ruleY([80]),
      Plot.text(
        ["To be implemented"],
        {
          x: 0,
          y: 40,
          fontSize: 48,
          fill: "var(--theme-foreground-faint)"
        }
      )
    ]
  }))
  ```

  </div>

</div>

## Storage Providers

The table below lists metrics for Filecoin Storage Providers.


```js
const storage_providers = FileAttachment("data/storage_providers.csv").csv({typed: true});
```

```js
Inputs.table(storage_providers, {
  columns: [
    "provider_id",
    "total_active_deals",
    "total_active_data_uploaded_tibs",
    "total_active_unique_clients",
    "first_deal_at",
    "last_deal_at",
    "raw_power_pibs",
    "quality_adjusted_power_pibs",
    "balance",
    "initial_pledge",
    "locked_funds",
    "provider_collateral",
    "capacity_utilization_ratio"
  ],
  header: {
    provider_id: "Provider ID",
    total_active_deals: "Active Deals",
    total_active_data_uploaded_tibs: "Active Data Uploaded (TiB)",
    total_active_unique_clients: "Active Unique Clients",
    first_deal_at: "First Deal At",
    last_deal_at: "Last Deal At",
    raw_power_pibs: "Raw Power (PiB)",
    quality_adjusted_power_pibs: "Quality Adjusted Power (PiB)",
    balance: "Balance",
    initial_pledge: "Initial Pledge",
    locked_funds: "Locked Funds",
    provider_collateral: "Provider Collateral",
    capacity_utilization_ratio: "Capacity Utilization Ratio"
  },
  sort: "total_active_deals",
  reverse: true,
  rows: 20,
  select: false,
  format: {
    provider_id: id => htl.html`<a href=/provider/${id} target=_blank>${id}</a>`
  }
})
```
