<nav>
  <a href="/">← Back to Home</a>
</nav>

<br>

# ${observable.params.provider}

```js
const provider_metrics = FileAttachment(`../data/${observable.params.provider}_daily_metrics.csv`).csv({typed: true});
```

## Retrievals

<div class="grid grid-cols-2">
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Retrieval Success Rate",
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
      })
    ]
  }))
  ```
</div>
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Retrieval Requests",
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

## Durability

<div class="card">

```js
resize((width) => Plot.plot({
  title: "Durability",
  subtitle: "Percentage of sectors that have faulted on a given day",
  x: { label: "Date" },
  y: {
    grid: true,
    label: "Fault Rate (%)",
    domain: [0, 100]
  },
  width,
  marks: [
    Plot.ruleY([0]),
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

## Other Metrics

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
