# Frequently Asked Questions <!-- omit in toc -->

- [What is the source data behind each of the graphs?](#what-is-the-source-data-behind-each-of-the-graphs)
- [How does this related to filrep.io?](#how-does-this-related-to-filrepio)
- [Who "owns" or "governs" this dashboard?](#who-owns-or-governs-this-dashboard)
- [Why are "spark" metrics shown for retrievability?](#why-are-spark-metrics-shown-for-retrievability)
- [Where is the source code?](#where-is-the-source-code)
- [Where do I go to ask questions or leave feedback?](#where-do-i-go-to-ask-questions-or-leave-feedback)

## What is the source data behind each of the graphs?
[Metrics](./metrics) answers common questions about each of the graphs. The data used in this dashboard comes from the [Filecoin Data Portal](https://filecoindataportal.xyz/).

## How does this related to filrep.io?
This dashboard has no connection with previous attempts at "evaluating" / "scoring" storage providers like [filrep.io](https://filrep.io).  Instead, this dashboard is attempting to provide visualization to the service classes and the corresponding service level objectives defined at https://github.com/filecoin-project/service-classes. 

## Who "owns" or "governs" this dashboard?
This dashboard has been getting bootstrapped by the ["Filecoin PMF Targets Working group"](https://www.notion.so/Filecoin-PMF-Targets-Working-Group-111837df73d480b6a3a9e5bfd73063de).  As of 202411, we haven't had to work through contentious decisions at the dashboard level.  We are presenting the data we have with the goal of supporting a market between onramps/data aggregators and SPs.  We generally bias towards showing more information with an eye towards how to organize it well.  Concerning service classes and their corresponding service level objectives, we are attempting to mirror the values defined in https://github.com/filecoin-project/service-classes.  If, for example. someone doesn't agree with the SLO-target value for a given SLI in a service class, that should get sorted out in the service-classes repo first, and then graphs will be updated here.  

## Why are "spark" metrics shown for retrievability?
It's acknowledged that Spark isn't the only possible way to measure retrievability.  If/as more retrievability metrics get built, they will happily be presented as well.  That said, at least as of 202411, there aren't other well-defined and onchain retrievabilitys metrics that we're aware of.  

## Where is the source code?
The dashboard source code lives at https://github.com/filecoin-project/filecoin-storage-providers-market.  Rendering the dashboard locally should be easily doable assuming one has an internet connection, which is needed for pulling data from the [Filecoin Data Portal](https://filecoindataportal.xyz/).

## Where do I go to ask questions or leave feedback?
If you see a bug in the dashboard, you're encouraged to open a PR to just fix it.  You can also open an issue in https://github.com/filecoin-project/filecoin-storage-providers-market.

If you have questions about any of the graphs that weren't answered by the linked-to documentatin, then please ppen an issue in https://github.com/filecoin-project/filecoin-storage-providers-market.  We'll get your question answered and ideally the docs updated so it's more self-service for the next person.

If you have questions or feedback on a service class definition, please engage at https://github.com/filecoin-project/service-classes.