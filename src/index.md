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
  <h1>Unique Deal Making Providers</h1>


  ```js
  Plot.lineY(daily_metrics, {x: "date", y: "unique_deal_making_providers"}).plot({y: {grid: true}})
  ```

  </div>

  <div class="card"><h1>Providers With Active Deals</h1>

  ```js
  Plot.lineY(daily_metrics, {x: "date", y: "providers_with_active_deals"}).plot({y: {grid: true}})
  ```

  </div>
  <div class="card"><h1>Providers With Power</h1>

  ```js
  Plot.lineY(daily_metrics, {x: "date", y: "providers_with_power"}).plot({y: {grid: true}})
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
