# Filecoin Storage Providers Market Dashboard

👋 **Welcome!** 🔎 Get visibility into the market between Storage Clients and Storage Providers.  🎯 The goal is to help Storage Clients like onramps and aggregators find potential Storage Providers, and to help Storage Providers understand how they are evaluated and compared.

- Learn more about the [metrics](metrics).
- Check the [code](https://github.com/filecoin-project/filecoin-storage-providers-market).

## Status

This dasbhoard is a scrappy work-in-progress to help spur discussion at [FDS-5 Bangkok](https://www.fildev.io/FDS-5) and shouldn't be viewed as canonical.  It is being worked on actively by members of the "[PMF Targets Working Group](https://protocollabs.notion.site/Filecoin-PMF-Targets-Working-Group-111837df73d480b6a3a9e5bfd73063de?pvs=4)".

```js
const daily_metrics = FileAttachment("data/daily_metrics.csv").csv({typed: true});
const daily_retrieval_metrics = FileAttachment("data/daily_retrieval_metrics.csv").csv({typed: true});

// Mutates the provided plotConfig by adding a caption if one doesn't exist
function addPlotCaption(plotConfig, href) {
  if (!plotConfig.caption) {
    plotConfig.caption = html`<a href="./metrics#${createAnchorId(plotConfig.title)}">❓ Learn More</a>`;
  }
  return plotConfig;
}

// Creates an anchor tag id from a string by:
// - Converting to lowercase
// - Replacing spaces and non-alphanumeric chars with hyphens
// - Removing consecutive hyphens
// - Trimming hyphens from start/end
function createAnchorId(str) {
  return str
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}
```

## Network-Wide Metrics

This is an aggregate view looking at all Storage Providers on the network.

### SP Activity

<div class="grid grid-cols-3">

  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "Providers Making State Market Deals",
    subtitle: "On a given day, how many providers made a state market deal.",
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
  })))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "Providers With Active State Market Deals",
    subtitle: "How many providers have active state market deals.",
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
  })))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "Providers With Power",
    subtitle: "How many providers have power in the network.",
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
  })))
  ```

  </div>
</div>

### Retrieval Service Class Conformance

<div class="grid grid-cols-2">
  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "Providers Meeting Retrieval SLI",
    subtitle: "Number of providers with >90% successful retrievals",
    x: { label: "Date" },
    y: { grid: true, label: "Providers", zero: true },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(daily_retrieval_metrics, {
        x: "date",
        y: "meet_retrieval_sli",
        tip: true
      })
    ]
  })))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "Providers Meeting Retrieval SLI (%)",
    subtitle: "Percentage of providers with >90% successful retrievals",
    x: { label: "Date" },
    y: {
      grid: true,
      label: "Percentage",
      domain: [0, 100]
    },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(daily_retrieval_metrics, {
        x: "date",
        y: d => d.meet_retrieval_sli_percent * 100,
        tip: true
      })
    ]
  })))
  ```

  </div>
</div>



### Service Class Conformance

<div class="grid grid-cols-2">
  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "\"Warm\" Service Class Conformance",
    subtitle: html`Percentage of providers conforming to warm service class`,
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
  })))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "\"Cold\" Service Class Conformance",
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
  })))
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
    provider_id: id => htl.html`<a href=/filecoin-storage-providers-market/provider/${id} target=_blank>${id}</a>`
  }
})
```

---

_Data used in this dashboard comes from the [Filecoin Data Portal](https://filecoindataportal.xyz/) andis available without any warranties or guarantees of any kind, either expressed or implied._
