# Technical Architecture for Office of National Statistics Website

## Principles

### User Needs

The ONS website serves a range of different kinds of users, some of which are better served by the current website than others.

  * **policy makers within government** are the primary audience for the statistical reports and analyses, which help them to plan and make decisions
  * **politicians and their advisers** try to identify top-line numbers from official statistics that support their policy arguments
  * **journalists** use statistics as the basis of stories; **data journalists** seek the underlying data in order to create new visualisations and views over data
  * **financial organisations** are particularly use financial information to help plan where to invest
  * **infomediaries** collect, clean and add value to official statistics and provide them as part of their packaged services
  * **application developers** use statistics, particularly demographic and geographic information, to provide better services
  * **the general public** use the website rarely currently, but could use it as a means for understanding the truth behind the numbers they see in the press

The challenge for the ONS website is creating a site that meets all these user needs. However, everyone benefits when the ONS provides information in a way that is easy to locate and easy to understand. If the site were oriented towards the general public, everyone would benefit.

Analysis carried out by ONS has identified three personas:

  * **David the Data Expert**, a statistician who primarily wants to get data from ONS to combine with his own data and perform further analyses
  * **Evie the Evidence Researcher**, a consumer of business data that she uses to inform her strategy at work
  * **Connie the Concerned Citizen**, who wants to fact check the figures that she sees in the press

It is also important to recognise the needs of the suppliers within ONS of information into the website, such as:

  * **ONS statisticians** who cleanse data, perform analyses and generate statistical reports
  * **ONS policy teams** who provide information about the datasets and their context
  * **ONS story creators** who make the data accessible to people by providing additional tools and infographics

### Domain-Driven Approach

Statistics are data, and the ONS website should be a data-based site. (Currently, it is a document-based site, oriented around the publication of reports.) We take a domain-driven approach to structuring the site, which has the following steps:

  1. We analyse the **types of things** that the site provides information about, and how they link together. This provides a domain model and informs the **structure of the URLs** for the site.
  2. We identify additional **section pages** that are implied by the defined URL structure, and the logical contents of those pages.
  3. We look at the **key entry points**, the information that users expect to see at those entry points, and **user journeys** from these entry points to other information within the site.
  4. We examine the **underlying data** required for the views and pages that are needed to underpin the site, and which would logically be expected to be accessible from each of the identified pages.

## Domain Models for Official Statistics

There are three sources of information for this domain model:

  1. the existing domain model in use on the ONS website
  2. existing standard domain models for statistics, such as the information model that underpins SDMX and DataCube
  3. informal domain models for statistics, which are exposed through the ways in which people reference statistics, with both official reports and in the press and social media
  
### Current ONS Domain Model

We need to understand the current ONS domain model for two reasons. First, it is the most easily apparent representation of the way in which ONS currently thinks about the information that it holds. Second, any information that are currently provided on the ONS website will also have to be provided by any revised website, and the URLs for existing pages will need to be handled.

> TODO: We need more information here, about how the data is structured by statisticians within ONS, eg whether they share things like "variables" across datasets, what the relationships are between the various types of things like Articles, Books, Datasets, Journals, Reference tables, Releases, Reports, Statistical bulletins and Summaries.

#### Releases

Releases are listed in the [Release calendar](http://www.ons.gov.uk/ons/release-calendar/index.html). Each release contains:

  * a number of publications (articles etc)
  * some summaries (video and other)
  * some data

#### Publications

There are five different types of publications:

  * Articles - academic articles
  * Books - not used
  * Journals
  * Reports
  * Statistical Bulletins - primary output
  
These do not seem to differ markedly in content (they contain narrative analysis and charts, structured into sections) although Journals contain multiple Articles.

Articles in particular may incorporate charts that show data from several datasets, and targeted tables which aren't included directly in releases.

> QUESTION: Do these have different official standing within ONS? Do they come with different expectations associated with them? Are Statistical Bulletins guaranteed to come at regular intervals, for example?

#### Data

There are two different types of data:

  * **Datasets**, which are raw data, available in CSV and other formats and without summaries
  * **Reference Tables**, which are the results of analyses
  
> TODO: More on this & relation to publications; articles etc often contain charts with specially created tables associated with them, need to work out where these come from.

### Standard Domain Models

#### OECD

The [OECD Glossary](http://stats.oecd.org/glossary/) contains some definitions of terms that may be useful. In particular, terms such as [Statistical Press Release](http://stats.oecd.org/glossary/detail.asp?ID=7344) and [Stastistial Products](http://stats.oecd.org/glossary/detail.asp?ID=7343) may prove useful for describing the narrative content associated with a data release.

#### SDMX Information Model

[SDMX](http://sdmx.org/?page_id=10) is designed as a (XML-based) format for exchanging national statistics, for example as input to [Eurostat](http://epp.eurostat.ec.europa.eu/portal/page/portal/eurostat/home/). As such it is designed around precisely what ONS do, and is something that ONS already has some experience of using.

The SDMX [Information Model](http://sdmx.org/wp-content/uploads/2011/08/SDMX_2-1-1_SECTION_2_InformationModel_201108.pdf) describes the domain model for SDMX. The core is mirrored in Data Cube, but the SDMX model includes some additional aspects which are useful when describing the routine publication of statistics.

#### Data Cube

[Data Cube](http://www.w3.org/TR/vocab-data-cube/) is a W3C Recommendation for representing statistics. It uses the same core data model as SDMX.

![image](http://www.w3.org/TR/vocab-data-cube/images/qb-fig1.png)

#### SKOS

[SKOS](http://www.w3.org/TR/skos-primer/) is a W3C Recommendation for representing concepts and concept schemes. It has particular utility in a statistical context for describing sets of valid codes for a given dimension.

#### DCAT

[DCAT](http://www.w3.org/TR/vocab-dcat/) is a W3C Recommendation for representing information about data catalogs. The ONS website could be considered a data catalog, and reuse some of the domain model defined within DCAT.

![image](http://www.w3.org/TR/vocab-dcat/dcat-model.jpg)

#### ORG

[ORG](http://www.w3.org/TR/vocab-org/) is a W3C Recommendation for representing information about organisations, which may prove useful for describing the various business units within ONS that publish statistics.

![image](http://www.w3.org/TR/vocab-org/img/OrgOntology20130502.png)

#### schema.org

[schema.org](http://schema.org) pulls together lots of different vocabularies. It has its own versions of classes for datasets and catalogs, incorporating DCAT and so on. But it doesn't include specifically statistical classes.

### Informal Domain Models

> TODO: this requires some kind of analysis of the existing ways in which statistics are quoted on websites; perhaps something that a student could do?

### Proposed Domain Model

The domain model that we set out here brings together the domain models that we have outlined above into a coherent model that can underpin the statistical information available on the ONS website.

> NOTE: This isn't complete; in particular the modelling of data-related content, releases and datasets &mdash; ie the relationship between data and text about the data &mdash; isn't right yet.

#### Content Stuff

> TODO: Need a deeper look at the different categories of content that are put on the ONS website, and how these relate to the underlying datasets.

#### Release Series

A release series is a regular release of datasets, in a series. For example, ONS commit to publishing statistics on how many adults live with their parents each year, as part of their Labour Force Survey. Each one of those releases contains datasets which have the same structure; this enables comparisons between releases and for the same (data) tools to be used on each release.

Each release series is identified through a URL like:

    /statistics/{series}
    
where `series` is a unique identifier for the series, preferably one that is easy for humans to understand. For example:

    /statistics/labour-market

The page for the series should directly provide information from the most recent data release within the series as well as links to historical releases and information about when the next release is due.

#### Data Release

A data release is the publication of some data and analysis of that data, on a particular date. Each data release corresponds to a particular release series. Data releases will usually happen at regular intervals. Each data release may include a number of datasets which provide different views on the analyses, as well as one or more reports.

The URL for a data release is:

    /statistics/{series}/{date}

where `series` is a unique identifier for the relase series that the release relates to, and `date` is the date of the particular release, in ISO8601 format (`YYYY-MM-DD`), for example:

    /statistics/labour-market/2014-01-22

#### Dataset

A dataset is an individual set of data within a data release. Some data releases will have a single dataset, others may have many if they include different dimensions, measures or attributes. Each sheet within an Excel file on the current site may be a separate dataset (though sometimes separate sheets provide different slices of the same statistical hypercube).

The URL for a dataset within a data release is:

    /statistics/{series}/{date}/{dataset}

where `series` is a unique identifier for the release series, the `date` is the data of the data release and `dataset` is a unique identifier for the dataset itself, for example:

    /statistics/labour-market/2014-01-22/

The date can be left out as follows:

    /statistics/{series}/{dataset}
    
to retrieve information about the most recent publication of the given dataset.

#### Observation

An observation is a single cell within the hypercube of a dataset. Each observation is identified through a combination of dimension values. All the dimensions that are applicable to the dataset must be specified for a given observation.

The URL for an observation is:

    /statistics/{series}/{date}/{dataset}{?dimension-values*}

The `dimension-values` are name-value pairs. There must be a single concrete value (no wildcards) specified for every dimension within the dataset.

URLs that specify dimension values may specify them in any order, but the canonical order is based on the dimension order specified for the dataset. If the server receives a request that includes a dimension order that isn't the canonical order, it should redirect to the URL that uses the canonical order. Normalising the dimension order in this way ensures that everyone uses a common URL to mean the same thing.

#### Slice

A slice is a specification of a set of observations within a given dataset which is specified by selecting a subset of dimension values from the data cube. If all the dimensions are narrowed down to a single value, that is an observation; a slice must have one or more dimensions that is a wildcard value.

Dimension values are usually hierarchies. For example, in data about adults living with parents, `age` is split up as follows:

    20-34
    +- 20-24
    |  +- 20
    |  +- 21
    |  +- 22
    |  +- 23
    |  +- 24
    |
    +- 25-29
    |  +- 25
    |  +- 26
    |  +- 27
    |  +- 28
    |  +- 29
    |
    +- 30-34
       +- 30
       +- 31
       +- 32
       +- 33
       +- 34
    
In this case the hierarchy is even (there are the same number of levels within each category), but in other cases the hierarchy can be uneven. For example when looking at geographies for a `geo` dimension, the hierarchy may be:

    UK
    +- England
    |  +- North East
    |  +- North West
    |  +- Yorkshire and The Humber
    |  +- East Midlands
    |  +- West Midlands
    |  +- East
    |  +- London
    |  +- South East
    |  +- South West
    |
    +- Wales
    +- Scotland
    +- Northern Ireland

The URL is the same as for an observation:

    /statistics/{series}/{date}/{dataset}{?dimension-values*}

but in this case:

  * Not all dimensions for the dataset need to be specified in the URL; if a dimension is missing then the values selected for it are all of the most granular values. For example, if the `age` dimension isn't specified, then it would mean individual ages (`20`, `21` etc) whereas if the `geo` dimension isn't specified, then it would cover all the regions in England, plus the three countries Wales, Scotland and Northern Ireland.

  * Dimension values may be wildcarded; this is used to step down different levels in the hierarchy. For example, `age=*` would select observations whose `age` dimension was a direct child of the top of the age hiearchy, ie `20-24`, `25-29` or `30-34`; `age=20-24/*` would select observations whose `age` dimension was a child of the `20-24` category, namely `20`, `21`, `22`, `23` or `24`; `age=*/*` would select the individual ages (equivalent in this case to omitting the `age` dimension altogether).

#### Concepts and Concept Schemes

Concepts are individual values for things like dimensions or attributes, which usually have a code associated with them. Sometimes concepts are also real-world things, like local authorities and it's useful to be able to point out to those concepts.

Within Data Cube, every dimension, measure, attribute and code used within a dataset relates to a separately defined concept. The work on [Harmonisation](http://www.ons.gov.uk/ons/guide-method/harmonisation/harmonisation-programme/index.html) within ONS demonstrates the utility of having a single definition for concepts such as "Economically active".

A URL structure for concepts might be

    /def/{scheme}/{code}

where `scheme` is a unique identifier for a concept scheme (such as SIC 2007) and `code` is an identifier for the code used within that concept scheme. For example:

    /def/economic-status/self-employed-full-time

It would be useful for these pages to include references to datasets that use the particular concept or concept scheme, so that it's easy to find datasets that can be combined with this one.

##### Geographic Concepts

The [statistics.data.gov.uk](http://statistics.data.gov.uk/) site provides URLs for geographies used within ONS. There are already two views for each of these geographies:

  * [through the Resource Viewer](http://statistics.data.gov.uk/explore?URI=http%3A%2F%2Fstatistics.data.gov.uk%2Fid%2Fstatistical-geography%2FE14000721)
  * [at the official URL, through a linked data API](http://statistics.data.gov.uk/doc/statistical-geography/E14000721)

Having more than one page for viewing this information is confusing, so addressing this (eg by having some redirections onto relevant pages within the site, or making sure the existing pages are styled consistently and contain other consistent information) would be useful.

## Section Pages

> TODO

## User Journeys

Different users will have different goals as they come to the ONS website. As with all websites, it should be possible for users to quickly find what they are looking for on the site.

However, because the ONS website is a data-driven website, it should also be possible to link to anything that someone might want to reference, for example within a report or an article. Users who follow the link should be presented with enough information to:

  * verify that the quoted information that they have read elsewhere is correct
  * better understand the context of the information that they find
  * further explore related information, to better understand it or find out more
  
### Living with Parents Example

In a report, it says

> 26% of adults aged 20-34 live with their parents

This phrase is linked to the page

    /statistics/living-with-parents/2014-01-21/by-year-gender-and-age?year=2013&gender=all&age=20-34

which is an Observation page.

#### Observation Page

On this page, the user sees some information which is available on all pages relating to this particular dataset:

  * a headline that shows they are looking at statistics about adults living with parents
  * a subheading that shows they are looking at a dataset that analyses adults living with parents by year, gender and age
  * an indication that this dataset was published on 21st January 2014
  * specific notes about the measures, such as:
      * > Once a person either lives with a partner or has a child, they are considered to have formed their own family and are no longer counted as being part of their parents’ family even if they still live in the same household. Therefore such people are deemed to be not living with their parents here.
      * > Students living in halls of residence during term-time and living with their parents outside term-time are counted as not living with their parents here.
      * > Estimates are all rounded to the nearest thousand.
  * information about the dataset and where it comes from, such as:
      * > The Labour Force Survey is a household survey of people in the UK. It covers people in private households, NHS accommodation and students in halls of residence whose parents live in the UK. However people in other communal establishments such as prisons are excluded. Results from the 2011 Census have not yet been incorporated into any weighting for these tables.
      * > As the estimates are based on a survey, they are subject to sampling variability. This is because the sample selected is only one of a large number of possible samples that could have been drawn from the population.
  
There is also some information that is specific to the Observation:
  
  * an indication that this Observation is the "current" value for this statistic (ie is the most recently published value for the most recent time period)
  * the summary of this particular observation (note not all observations have related summaries), from the report related to this dataset, which says:
      * > In 2013, over 3.3 million adults in the UK aged between 20 and 34 were living with a parent or parents. That is 26% of this age group.
  * the figure 26%, which confirms the reported figure
  * the figure 3,349,000, which is the number of people that this percentage corresponds to
  * an indication that the figures relate to the entire UK
  * an indication that the figures relate to the year 2013
  * an indication that the figures relate to both men and women
  * an indication that the figures are for adults aged 20-34

The user is invited to do some things which they are invited to do on every page related to this dataset:

  * find out more about the Living with Parents statistics
  * find out more about the two datasets that form the Living with Parents release:
      * the analysis by year, gender and age (this analysis)
      * the analysis by 3-year average, region and age (the other analysis published at the same time)
  * find out more about the Labour Force Survey
  * find out more about the methodology and quality control behind the statistics
  * download the whole dataset, in:
      * a 'data kit' zip of all the data (in CSV format), concept schemes, and region boundaries for developer use
      * an Excel spreadsheet holding the metadata and datasets on different tabs for casual user use
      * an SDMX version of the dataset
  * look at other similar datasets (eg those that share dimensions with this one)

The user is also invited to do some things which relate specifically to exploring more about this Observation:
  
  * compare the figure with previous years
  * compare the figure between genders
  * compare the figure across age groups
  * find out more about the UK as a geography
  * find out more about what the year '2013' means in this dataset (ie in some datasets this might not be calendar year)
  * find out more about what 'all' genders means (ie what happens with those who don't classify themselves as male or female)
  * find out more about what 'age 20-34' means
  * access JSON data for:
      * the "always current" latest living with parents statistic (total across the UK)
      * this particular observation
  * embed as HTML in their website for:
      * the "always current" latest living with parents statistic
      * this particular observation
  * copy a link to:
      * the "always current" latest living with parents statistic
      * this particular observation

The user opts to compare the figure with previous years. This takes them to the page:

    /statistics/living-with-parents/2014-01-21/by-year-gender-and-age?gender=all&age=20-34

which is a Time Series page (a particular type of Slice page).

#### Time Series Page

On this page they can alternate between two bar graphs (or line graphs? whichever is supposed to be best for this type of data) that show the change in the number of adults living with parents between 1996 and 2013:

  * **Percentages** shows a graph of the percentages of adults living with parents
  * **Numbers** shows a graph of the number of adults living with parents

Each of these views is identified through a particular URL, for example:

    /statistics/living-with-parents/2014-01-21/by-year-gender-and-age?gender=all&age=20-34#percentage

On clicking on a point/bar on the graph, a pop-up shows:

  * the year that it relates to
  * the value that it relates to
  * a link to more details about that observation

This highlight is identified through a URL; for example highlighting the value for the year 2000 would be the URL:

    /statistics/living-with-parents/2014-01-21/by-year-gender-and-age?gender=all&age=20-34#percentage;year=2000

If several data points are selected (by holding down the shift key and selecting another point), these are highlighted with their figures and the difference between them, to enable comparisons to be made. These comparisons are also identified by URLs, for example the comparison between 2013 and 1996 would be shown at:

    /statistics/living-with-parents/2014-01-21/by-year-gender-and-age?gender=all&age=20-34#percentage;year=1996;year=2013

The Time Series page also provides the following information in addition to that available on every page related to this dataset:

  * an indication that this Time Series is the "current" time series (ie is the most recently published dataset for this statistic)
  * the summary of points on this particular Time Series, or related to the entire Time Series (note not all Time Series have related summaries), from the report related to this dataset, which says:
      * > In 2013, over 3.3 million adults in the UK aged between 20 and 34 were living with a parent or parents. That is 26% of this age group.
      * > The earliest year for which comparable statistics are available is 1996, when 2.7 million 20 to 34-year-olds lived with their parents, 21% of this age group.
      * > This means that the number of 20 to 34-year-olds living with their parents has increased by 669,000 (or 25%) since 1996. This is despite the number of people in the population aged 20 to 34 being largely the same in 1996 and 2013 after a fall between 2002 and 2006. This rise in the number of young adults living with their parents has been recognised by academic research.
  * an indication that the figures relate to the entire UK
  * an indication that the figures relate to both men and women
  * an indication that the figures are for adults aged 20-34

As well as the usual links related to the dataset, and the links to the individual observations in the time series, the user is invited to:

  * see more detail about particular observations, by clicking on the graph as described above
  * compare observations within the Time Series, by selecting two or more points on the graph
  * compare the figures between genders
  * compare the figures across age groups
  * find out more about the UK as a geography
  * find out more about how years are measured in this dataset
  * find out more about what 'all' genders means (ie what happens with those who don't classify themselves as male or female)
  * find out more about what 'age 20-34' means
  * access JSON data for:
      * the "always current" latest living with parents time series
      * this particular time series (from this publication)
  * embed as HTML in their website for:
      * the "always current" latest living with parents time series graph
      * this particular time series
  * copy a link to:
      * the "always current" latest living with parents time series
      * this particular time series

The user chooses to compare the figures across age groups. This takes them to the page:

    /statistics/living-with-parents/2014-01-21/by-year-gender-and-age?gender=all&age=*#percentage

This is another series page, which displays similar information except that in the graphs show lines/bars for each of the age groups `20-24`, `25-29` and `30-34`.

From this page, the user decides to find out more about the other data analysis (by region). They navigate to:

    /statistics/living-with-parents/2014-01-21/by-region-age-and-time

which is a Dataset page.

#### Dataset Page

A dataset page is a primarily editorial page that provides a few key points of information which can be used as a leaping-off point for exploring the analysis of the data. For the particular dataset that looks at how many adults live with their parents in different regions, these key points might be:

  * > The percentage of young adults who were living with their parents varies across the UK
  
    which links to the Geographical Series `/statistics/living-with-parents/2014-01-21/by-region-age-and-time?time=2011-2013&age=20-34`
    
  * > London had the lowest percentage of young adults living with parents
  
    which links to the Observation `/statistics/living-with-parents/2014-01-21/by-region-age-and-time?time=2011-2013&age=20-34&geo=London`
    
  * > Northern Ireland had the highest percentage of young adults living with parents
  
    which links to the Observation `/statistics/living-with-parents/2014-01-21/by-region-age-and-time?time=2011-2013&age=20-34&geo=Northern%20Ireland`

It also contains the information that is always shown on pages about this dataset. It also provides some additional information:

  * a list of the dimensions that this dataset uses
  * an indication of the size of the dataset (number of observations)

As well as the usual things that the user is invited to do with this dataset, the user is also invited to:

  * delve into the data through the key points that have been highlighted (editorially)
  * look instead at the related "by region" dataset

