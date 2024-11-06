# Metric Definitions <!-- omit from toc -->

Below are explanatory notes on the metrics that that are visualized on this dashboard.  One can always check the [dashboard source code](https://github.com/filecoin-project/filecoin-storage-providers-market) to confirm accuracy.

- [Abbreviations](#abbreviations)
- [Aggregate Metrics](#aggregate-metrics)
  - [Providers Making State Market Deals](#providers-making-state-market-deals)
  - [Providers With Active State Market Deals](#providers-with-active-state-market-deals)
  - ["Warm" Service Class Conformance](#warm-service-class-conformance)
  - ["Cold" Service Class Conformance](#cold-service-class-conformance)
- [Individual Storage Provider Metrics](#individual-storage-provider-metrics)
  - [Spark Retrieval Success Rate](#spark-retrieval-success-rate)
  - [Spark Retrieval Requests](#spark-retrieval-requests)
  - [State Market Deals Data Onboarding](#state-market-deals-data-onboarding)
  - [State Market Deals](#state-market-deals)
  - [Raw Power](#raw-power)
  - [Quality Adjusted Power](#quality-adjusted-power)


## Abbreviations
The following abbreviations are used throughout this page and site:
* SLI - service level indicator
* SLO - service level objective
* SP - storage provider.  And by "storage provider", we mean the entity as defined in the Filecoin protocol with an individual id that commits sectors, accepts deals, etc.

## Aggregate Metrics
These are metrics looking across all storage providers in the network.  They correspond with the aggregate views displayed at the [dashboard home](/).

### Providers Making State Market Deals
This looks at the number of providers who made a state market deal on a given day.  This gives a sense of the number of "active storage providers".

### Providers With Active State Market Deals
On a given day, how many storage providers have a active state market deals.  This gives a sense of the number of "active storage providers".

### "Warm" Service Class Conformance
This shows the number of Storage Providers in a given day that met the ["warm" service class service level objectives](https://github.com/filecoin-project/service-classes/service-classes/warm.md).  If a given SP only meets some of the SLOs, these are highlighted as well.

### "Cold" Service Class Conformance
This shows the number of Storage Providers in a given day that met the ["cold" service class service level objectives](https://github.com/filecoin-project/service-classes/service-classes/cold.md).  If a given SP only meets some of the SLOs, these are highlighted as well.

## Individual Storage Provider Metrics
These are metrics that specific to an individual SP at `/provider/providerId`.

### Spark Retrieval Success Rate
This shows a Storage Provider's [Spark Retrieval Success Rate](https://github.com/filecoin-project/service-classes/service-level-indicators/spark-retrieval-success-rate.md).  The horizontal line's value, which corresponds with a service level objective, is defined in the supporting [service class definition](https://github.com/filecoin-project/service-classes/service-classes) (e.g; ["warm"](https://github.com/filecoin-project/service-classes/service-classes/warm.md)).

### Spark Retrieval Requests
This shows the number of Spark Retrieval Requests that were made and accepted each day.  This is the denominator of the [Spark Retrieval Success Rate](#spark-retrieval-success-rate).  It is showed so one can get a sense of how much retrieval checking was done for an SP for a given day.  Note that this doesn't show the number of unique CIDs an SP had checked, but rather the total number of checks.

### State Market Deals Data Onboarding
The amount of data onboarded by an SP for a given day via the State Market actor.

### State Market Deals
The number of deals in a day that were made by an SP via the State Market actor.

### Raw Power
The amount of raw power an SP had when sampled each day.

### Quality Adjusted Power
The amount of quality adjust power (QAP) an SP had when sampled each day.

_[Back](/)_.
