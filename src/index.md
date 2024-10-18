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

## Storage Providers

The table below lists metrics for Filecoin Storage Providers.


```js
const storage_providers = FileAttachment("data/storage_providers.csv").csv({typed: true});
```

```js
Inputs.table(storage_providers)
```
