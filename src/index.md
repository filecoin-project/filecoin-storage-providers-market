# Filecoin Storage Providers Market Dashboard <!-- omit from toc -->

👋 **Welcome!** 🔎 Get visibility into the market between Storage Clients and Storage Providers.  🎯 The goal is to help Storage Clients like onramps and aggregators find potential Storage Providers, and to help Storage Providers understand how they are evaluated and compared.

- Learn more about the [metrics](metrics).
- Check the [code](https://github.com/filecoin-project/filecoin-storage-providers-market).

- [Status](#status)
- [Network-Wide Metrics](#network-wide-metrics)
  - [SP Activity](#sp-activity)
  - [Service Class Conformance](#service-class-conformance)
    - ["Warm" Service Class Conformance](#warm-service-class-conformance)
    - ["Cold" Service Class Conformance](#cold-service-class-conformance)
- [Storage Providers List](#storage-providers-list)


## Status

* 2024-12-03: This dashboard is a work-in-progress to give visualization to in-progress [Service Class definitions](https://github.com/filecoin-project/service-classes) and measurement.  It is being worked on actively by members of the "[PMF Targets Working Group](https://protocollabs.notion.site/Filecoin-PMF-Targets-Working-Group-111837df73d480b6a3a9e5bfd73063de?pvs=4)".

```js
const daily_metrics = FileAttachment("data/daily_metrics.csv").csv({typed: true});
const daily_providers_metrics = FileAttachment("data/daily_providers_metrics.csv").csv({typed: true});

// TODO: factor out these helper functions so they can be used on the "provider detail pages" as well.

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

These are aggregate views looking at all Storage Providers on the network.

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


### Service Class Conformance

Service Classes and their corresponding Service Level Objectives are defined in [filecoin-project/service-classes](https://github.com/filecoin-project/service-classes).

#### ["Warm" Service Class Conformance

[📚 Definition.

<div class="grid grid-cols-2">

  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "\"Warm\" Service Class Conformance: Retrievability",
    subtitle: html`Providers meeting the "Warm" service class retrievability SLO`,
    x: { label: "Date" },
    y: {
      grid: true,
      label: "# of SPs",
    },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(daily_providers_metrics, {
        x: "date",
        y: "meet_retrieval_sli",
        tip: true,
      })
    ]
  })))
  ```

  </div>

  <div class="card">

  ```js
  resize((width) => Plot.plot(addPlotCaption({
    title: "\"Warm\" Service Class Conformance: Sector Health",
    subtitle: html`Providers meeting the "Warm" service class sector health SLO`,
    x: { label: "Date" },
    y: {
      grid: true,
      label: "# of SPs",
    },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(daily_providers_metrics, {
        x: "date",
        y: "meet_sector_health_sli",
        tip: true,
      })
    ]
  })))
  ```

  </div>
</div>

#### "Cold" Service Class Conformance

[📚 "Cold" Service Class README](https://github.com/filecoin-project/service-classes/blob/main/service-classes/cold.md).


<div class="card">

```js
resize((width) => Plot.plot(addPlotCaption({
  title: "\"Cold\" Service Class Conformance",
  subtitle: "Providers conforming to archive SLO standards",
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

## Storage Providers List

The table below lists metrics for Filecoin Storage Providers.  More metrics including service class performance graphs can be viewed by clicking into a given SP.  ([Tracking issue to expose service class metrics into the table below](https://github.com/filecoin-project/filecoin-storage-providers-market/issues/9).)

```js
const storage_providers = FileAttachment("data/storage_providers.csv").csv({typed: true});
```

<div id="storage-providers-table">

```js
Inputs.table(storage_providers, {
  columns: [
    "provider_id",
    "days_meet_both_slos",
    "proportion_days_meet_both_slos",
    "days_meet_retrieval_slo",
    "days_meet_sector_health_slo",
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
    days_meet_both_slos: "Days Meeting Both SLOs",
    proportion_days_meet_both_slos: "Proportion Days Meeting Both SLOs",
    days_meet_retrieval_slo: "Days Meeting Retrieval SLO",
    days_meet_sector_health_slo: "Days Meeting Sector Health SLO",
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
  sort: "proportion_days_meet_both_slos",
  reverse: true,
  rows: 20,
  select: false,
  format: {
    provider_id: id => htl.html`<a href=./provider/${id} target=_blank>${id}</a>`
  }
})
```
</div>