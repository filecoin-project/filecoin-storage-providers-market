<nav>
  <a href="/">← Back to Home</a>
</nav>

<br>

# ${observable.params.provider}

```js
const provider_metrics = FileAttachment(`../data/${observable.params.provider}_daily_metrics.csv`).csv({typed: true});
```

<div class="grid grid-cols-2">
<div class="card">

  ```js
  resize((width) => Plot.plot({
    title: "Onboarded Data",
    caption: "Data onboarded in TiB",
    x: {label: "Date"},
    y: {grid: true, label: "TiB"},
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
    title: "Deals",
    caption: "Showing only State Market deals",
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
