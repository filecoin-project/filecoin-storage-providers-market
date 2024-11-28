# ${observable.params.provider} <!-- omit from toc -->

- [Service Class Performance](#service-class-performance)
  - ["Warm" Service Class](#warm-service-class)
    - [Retrievability](#retrievability)
    - [Durability](#durability)
- [Storage Provider Activity](#storage-provider-activity)
  - [Deals](#deals)
  - [Power](#power)
  - [Sectors](#sectors)

```js
const provider_metrics = FileAttachment(`../data/${observable.params.provider}_daily_metrics.csv`).csv({typed: true});
```

## Service Class Performance

_How an SP performs against the [various defined service classes and their coresponding service level objectives](https://github.com/filecoin-project/service-classes)._

### "Warm" Service Class

_How an SP performs again the [(TBD) "warm" service class](https://github.com/filecoin-project/service-classes/service-classes/warm.md)._

#### Retrievability

<div class="grid grid-cols-2">
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Spark Retrieval Success Rate",
    subtitle: "Percentage of successful retrievals",
    x: {label: "Date"},
    y: {
      grid: true,
      label: "Success Rate (%)",
      domain: [0, 100]
    },
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(provider_metrics, {
        x: "date",
        y: d => d.successful_retrieval_requests / d.total_retrieval_requests * 100 || 0,
        stroke: "orange",
        tip: true
      }),
      Plot.ruleY([90], {stroke: "green", strokeWidth: 3})
    ]
  }))
  ```

</div>
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Spark Retrieval Requests",
    x: {label: "Date"},
    y: {grid: true, label: "Requests"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(provider_metrics, {
        x: "date",
        y: "total_retrieval_requests",
        stroke: "steelblue",
        tip: true
      }),
      Plot.lineY(provider_metrics, {
        x: "date",
        y: "successful_retrieval_requests",
        stroke: "seagreen",
        tip: true
      })
    ],
    color: {
      legend: true,
      domain: ["Total Requests", "Successful Requests"],
      range: ["steelblue", "seagreen"]
    }
  }))
  ```

</div>
</div>

#### Durability

<div class="grid grid-cols-2">

<div class="card">

```js
resize((width) => Plot.plot({
  title: "Sector Health Rate",
  subtitle: "Percentage of sectors that have submitted an accepted proof of spacetime.",
  x: { label: "Date" },
  y: {
    grid: true,
    label: "Health Rate (%)",
    domain: [0, 100]
  },
  width,
  marks: [
    Plot.ruleY([0]),
    Plot.rectY(provider_metrics, {
      x: "date",
      y: "sector_health_rate",
      fill: "orange",
      fillOpacity: 0.6,
      interval: "day",
      tip: true
    }),
    Plot.ruleY([95], {stroke: "green", strokeWidth: 3}),
  ]
}))
```

</div>

<div class="card">

```js
resize((width) => Plot.plot({
  title: "Active Sectors",
  subtitle: "Number of active sectors per day.",
  x: {label: "Date"},
  y: {grid: true, label: "Sectors"},
  width,
  marks: [
    Plot.ruleY([0]),
    Plot.lineY(provider_metrics, {
      x: "date",
      y: "active_sectors",
      stroke: "steelblue",
      tip: true
    })
  ]
}))
```

</div>

</div>

## Storage Provider Activity

### Deals

<div class="grid grid-cols-2">
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "State Market Deals Data Onboarding",
    subtitle: "Data onboarded via state market deals",
    x: {label: "Date"},
    y: {grid: true, label: "TiBs"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(provider_metrics, {
        x: "date",
        y: "onboarded_data_tibs",
        tip: true
      })
    ]
  }))
  ```

</div>

<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "State Market Deals",
    subtitle: "Showing only State Market deals",
    x: {label: "Date"},
    y: {grid: true, label: "Deals"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(provider_metrics, {
        x: "date",
        y: "deals",
        tip: true
      })
    ]
  }))
  ```

</div>
</div>

### Power

<div class="grid grid-cols-2">
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Raw Power",
    caption: "Raw power in PiB",
    x: {label: "Date"},
    y: {grid: true, label: "PiB"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(provider_metrics, {
        x: "date",
        y: "raw_power_pibs",
        tip: true
      })
    ]
  }))
  ```

</div>

<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Quality Adjusted Power",
    caption: "Quality adjusted power in PiB",
    x: {label: "Date"},
    y: {grid: true, label: "PiB"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.lineY(provider_metrics, {
        x: "date",
        y: "quality_adjusted_power_pibs",
        tip: true
      })
    ]
  }))
  ```

</div>
</div>

### Sectors

<div class="grid grid-cols-2">
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Sector Added Events",
    caption: "Number of sector added events",
    x: {label: "Date"},
    y: {grid: true, label: "Count"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.rectY(provider_metrics, {
        x: "date",
        y: "sector_added_events_count",
        tip: true,
        interval: "day"
      })
    ]
  }))
  ```

</div>

<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Sector Faulted Events",
    caption: "Number of sector faulted events",
    x: {label: "Date"},
    y: {grid: true, label: "Count"},
    width,
    marks: [
      Plot.ruleY([0]),
      Plot.rectY(provider_metrics, {
        x: "date",
        y: "sector_faulted_events_count",
        tip: true,
        interval: "day"
      })
    ]
  }))
  ```

</div>
</div>
