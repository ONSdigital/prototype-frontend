# Notes on working with the Producer Price Index data

This document has some notes and feedback for the ONS based on developing the prototype application and the data conversion scripts.

While these notes focus on the Producer Price Index (PPI) data many of the comments apply to other ONS statistical datasets.

The feedback comes from the perspective of a non-expert user, e.g. the "Evie the Evidence Researcher" persona identified by the ONS. 

The intention is to provide some insight into the types of questions that users working with the data are likely to ask, and issues that might be faced. While for the most part, working with the raw data is relatively straight-forward, the lack of supporting documentation presents a number of challenges to re-users.

These issues are outlined in the following sections along with some suggested improvements.

## Lack of archive downloads

Originally the goal for the prototype was to process a number of releases of the PPI to provide a larger corpus to work on.

However the ONS don't publish archival data for each of the statistical releases. Both the [January 2014](http://www.ons.gov.uk/ons/rel/ppi2/producer-price-index/january-2014/tsd-producer-price-index--january-2014.html) and [February 2014](http://www.ons.gov.uk/ons/rel/ppi2/producer-price-index/february-2014/tsd-producer-price-index--february-2014.html) datasets refer to the same set of file downloads.

This makes it harder to collect and compare data for individual releases. In constrast the summary references tables for each release are available as separate downloads. 

__Recommendation__: archive all data for all releases, regardless of format. Provide clear guidance to users on how to obtain the latest data or archival copies

## Reference Table Formats

While the source data is available in a number of formats, including XML and CSV, the reference tables associated with a statistical release are only available as formatted Excel spreadsheets. 

A user may only be interested in the summary data, e.g. percentage changes in price indexes, having these published in a similar range of formats would make processing easier.

__Recommendation__: publish all data in a consistent set of open, standard formats

## Dataset Documentation

There is very little documentation available to help re-users understand the dataset. Whilst working with the data we had to research on the ONS website to try and identify the meanings of a number of the dimensions, attributes and measures used in the data. Much of this research involved googling for terms in the dataset: in some cases this flagged up that some information was available on the ONS website, but buried in separate PDF documents.

For example:

* Terms like Seasonal Adjustment or Index Period are used in the data but not defined
* The XML data includes a dimension of "price index" and an attribute of "price". Documentation would clarify the differences between these two terms: the latter is not a price but a controlled list of terms
* There are lots of codes used in the data but which are not defined anywhere. E.g. the "price" attribute can have values of "CONS" or "NONE", but these codes are not documented. 
* The dataset includes attributes of "base period" and "index period". While the latter is used to reference the 2010 basis for calculating the price indexes, this was confirmed by inspecting the data. Neither term is defined. Confusingly the documentation associated with the release refers to the "base year", so the terminology is inconsistent

__Recommendation__: ensure that all dimensions, attributes, measures and code lists used in datasets are clearly documented. The documentation should be available directly from the statistical data and included in the machine-readable downloads.

## Reference Tables use attributes not present in raw data

The PPI statistical bulletins and reference tables note that in a number of cases that observations in the data are qualified in some way, e.g:

* are _provisional_
* have been _revised_
* are based on _limited coverage_ of a industry or sector

In the reference tables these attributes are included via additional codes that qualify individual values. However these qualifiers are not present in the raw dataset downloads. This means that someone working with the raw data would have to manually correlate this information across different sources.

__Recommendation__: ensure that all relevant statistical attributes are included in the machine-readable data

## Statistical Contacts

The statistical release pages on the website include names, email and telephone numbers for ONS staff to contact in case there are questions about the data.

The only machine-readable version of this data is included in the XML download. However the XML includes a different set of contact details, so there was some uncertainty about who to approach with questions around the data.

__Recommendation__: have a single contact point for questions around data issues and documentation, with expectations on response times

## Product Categories

The PPI dataset is relatively simple, consisting of two dimensions: product and date. Correctly interpreting the data involves some understanding of the various product categories that are being reported on.

However there is no public documentation available on the product categories being used or on how they relate to one another.
This makes it extremely difficult for anyone without inside knowledge of the dataset to re-use the data.

The following issues surfaced during the data conversion process:

* __Truncated Titles__: Category titles are often truncated, e.g. "PPI: 7169215000: Input component - Imported products used in the Manufacture Of". The important part of the title has been truncated here, so it is unclear what this category means. This is repeated in many of codes and not just in the raw data but in the time series views on the website.
* __Lack of Descriptions__: Categories don't have any associated descriptions that would help guide intepretation
* __Different Coding Schemes__: There are two different coding schemes in evidence. E.g. the dataset "CDID" code of "MC3Y" is defined as "6107310600: GSI (excl. CCL) - Inputs for Manf of grain mill,starches & starch pr". The code in the title is a structured identifier that apparently contains some mappings to SIC codes, but documentation on the structure of the codes, how they are to be interpreted, and mappings to standard code lists are not available. The formatting of the titles also varies, requiring heuristics to parse out the additional codes.
* __High level categories missing__: The statistical bulletins & reference tables organise the observations into two broad categories: input and output prices. However this grouping isn't present in the raw data. Some discussion with ONS contacts suggest that it may be possible to extract it from the secondary code scheme embedded in the product titles. These categories seem significant in presenting and interpreting the data so should be present in the raw data
* __Detailed categories missing__: There is clearly some additional hierarchy in the codes. E.g. "JVZ8: 7200700010: Net Sector Output - All Manufacturing excluding duty" is presumably the parent of a number of other manufacturing related codes. Having this structure available would make it easier for users to find and use aggregate statistics.
* __Missing CDID definitions__: The reference tables refer to CDID values which are not used in the raw XML downloads, suggesting that there is some unpublished data or analysis

__Recommendation__: ensure that the product code list is clearly documented and made available in a machine-readable format; extract codes from titles of time series and publish separately; where possible publish links to standard schemes like SIC codes


