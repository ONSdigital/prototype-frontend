# System Architecture for ONS Website

The ONS website needs to serve a mixture of editorial content (including statistical releases, visualisations, infographics, stories and so on) and statistical/numerical content.

## Infrastructure

We recommend using cloud computing infrastructure to enable automated deployment and automated scaling. We recommend using [OpenStack](https://www.openstack.org/) as a vendor-neutral platform for managing cloud computing resources. We have had success doing this using Chef and Vagrant and with RackSpace as a host.

We recommend putting in place infrastructure to support continuous testing, integration and deployment. We have had success using GitHub and Travis to support this.

We recommend putting in place monitoring for the machines that are in use, and having dashboards to display the health of the system in real time. This can help identify servers that are behaving poorly early. We have had success using Pingdom and Dashing, but could do more ourselves in this area.

## Managing Updates

There are two kinds of updates which the system needs to cater for:

1. **Daily updates to data and content:** When new statistics are published on the ONS website, they are usually released at precisely 9:30. The data can be very sensitive prior to this time, so the security around that data release needs to be tight.
2. **Routine updates to application code:** Any new ONS website will have to be a site that is able to evolve over time. This will require changes to application code, and potentially to data structures within the MongoDB store (though this should be avoided).

### Data / Content Updates

The ideal way of managing updates to data and content on the website would be to use in-application logic to control what is exposed on the public website. This has the advantage of enabling the pre-publication upload of statsitics prior to release, with automated publication of queued material at precisely 9:30. It also opens the possibility of enabling authors to preview the way the data will look on the site, and thus to catch any errors before publication.

It is also possible to use in-application logic to provide for early access to specific registered individuals.

### Application Updates

We recommend the use of [blue/green deployment](http://martinfowler.com/bliki/BlueGreenDeployment.html). This runs several servers in parallel and uses routing to make different servers visible to the outside world with zero downtime during redeployment. We recommend using three sets of machines in parallel:

1. **live** machines that currently serve the website
2. **backup** machines that currently serve the previous set of application code
3. **staging** machines that currently serve the most recently developed code; these should be accessible internally to preview and user test application changes

The crucial part of any such scheme is to make small iterative changes on a regular basis (ie that 'live' and 'staging' are always very similar to each other).

> NOTE: An alternative is to run continuous deployment so that the three environments are updated based on tags within the git repo; either way there should be a mentality of updating frequently

## Managing Load

The ONS site currently serves about 450k unique users each month. This was about 1m users each month before the site was redesigned; at that point it sunk to about 300k / month before gradually increasing.

Many of the assets (eg dated data releases) on the site will not change and so should be highly cacheable. More insight into the level of demand and other constraints on infrastructure scaling will be 
required to scope out a reasonable caching strategy.

## Software Architecture

### Editorial Content

The platform developed by the Government Digital Service (GDS) to underpin GOV.UK has proven to be an effective method of creating a content-based website that is driven through an API. One big advantage of using that system is that the same content can be easily and flexibly displayed on multiple pages within a single site, and onto multiple frontend sites. This may prove useful for ONS if it chooses to set up separate subsites for different user communities.

The GDS publication platform has several interconnected applications that interface with an underlying MongoDB store that holds structured content. These can be grouped into:

1. applications which are used for managing/authoring content:
    * **signonotron2** which is a user-facing application that manages users and permissions
    * **panopticon** which manages the metadata about content artefacts held within MongoDB
    * **publisher** which manages the versions of and the content of the artefacts, and the process of drafting, reviewing and publishing those artefacts

2. applications that serve content:
    * **static** which provides an API that manages static assets that are used across multiple sites, such as templates and stylesheets
    * **content_api** which provides an API onto the artefacts

3. front-end applications then call the **static** and **content_api** APIs to create a website; these are generally written as Ruby on Rails applications, using gems that make access to the **static** and **content** APIs easier

In many ways this combination of applications replicate the functionality of content management systems such as Wordpress or Drupal, but they have advantages in:

  * flexibility
  * customisability
  * automated testing
  * automatic deployment

### Statistical Content

To provide flexibility, referenceability and accessibility, the statistical content on the ONS website needs to be thought of as data, rather than spreadsheet attachments to content.

We recommend that the data is stored within a MongoDB database. This is recommended because:

  * statistics have varying dimensions and values and therefore suit a NoSQL (schemaless) database; NoSQL databases are also good during alpha development because they provide flexibility while exploring the problem space
  * MongoDB-style queries are suitable for the types of retrieval of data points that we envision will be needed in any API
  * there will be limited writes to the data platform (mostly focused on publication of new statistics each day), which means it's not necessary to use something that can handle heavy writes, such as Cassandra
  * there's no need for master/master replication (if there were, that would argue for using CouchDB)
  * the statistics served by the platform will be pre-calculated by statistical packages, which means MongoDB's deficiencies around performing calculations aren't an issue
  * MongoDB is used within the GOV.UK platform so the same MongoDB expertise can be used for both platforms
  
New data should be supplied through uploading specially formatted Excel files into the system. This provides statisticians with a familiar tool for creating data and a mechanism for uploading several data tables at the same time. If this proves successful, an Excel plugin could help with validation and upload of the data.
  
## Mixing Data and Content

Statistical releases combine statistics and commentary on those statistics. We can split these into **notes** which necessary for interpreting and understanding statistics, such as:

> Using estimates for one year for UK countries and English regions means that the percentages vary between years due to the sample size of the estimates. Therefore three years of data have been aggregated together to form a more robust estimate.

and **narrative** which describe the results of the statistical analysis over the data, such as:

> The earliest year for which comparable statistics are available is 1996, when 2.7 million 20 to 34-year-olds lived with their parents, 21% of this age group.
> 
> This means that the number of 20 to 34-year-olds living with their parents has increased by 669,000 (or 25%) since 1996. This is despite the number of people in the population aged 20 to 34 being largely the same in 1996 and 2013 after a fall between 2002 and 2006. This rise in the number of young adults living with their parents has been recognised by academic research.

These are all helpful annotations and should be stored such that they can supplement views of the data within the website, as well appear in narrative descriptions of those statistics. They should also appear within data delivered through APIs or within dumped content.

Authors of both notes and narrative will need to be able to associate those annotations with data (sometimes individual data points, sometimes slices of data, sometimes whole datasets). There needs to be some thought about how that is best managed.
