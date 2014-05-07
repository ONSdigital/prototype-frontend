[![Build Status](http://img.shields.io/travis/ONSdigital/prototype-frontend.svg)](https://travis-ci.org/ONSdigital/prototype-frontend)
[![Dependency Status](http://img.shields.io/gemnasium/ONSdigital/prototype-frontend.svg)](https://gemnasium.com/ONSdigital/prototype-frontend)
[![Code Climate](http://img.shields.io/codeclimate/github/ONSdigital/prototype-frontend.svg)](https://codeclimate.com/github/ONSdigital/prototype-frontend)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://ONSdigital.mit-license.org)
[![Badges](http://img.shields.io/:badges-5/5-ff6799.svg)](https://github.com/pikesley/badger)

Open Statistics Prototype
=========================

This is a prototype application that explores ideas for publishing statistical data on the web. The application was built by the Open Data Institute on behalf of the Office of National Statistics. The background on the project and the ideas being explored have been captured in [this blog post](http://theodi.org/blog/publishing-open-statistical-data).

A demonstration version of this application can be found at:

[http://open-statistics.herokuapp.com/](http://open-statistics.herokuapp.com/)

## Application Components

The application is made up of three components:

* The prototype website (this repo)
* A [statistical data API](https://github.com/ONSdigital/ons-data-api) which provides access to the raw data, this is deployed separately
* Some [domain objects capturing the data model](https://github.com/ONSdigital/ons_data_models) used in the API (only)

The application is intended to be backed by a Mongo database which stores the underlying statistical data.

The API provides views over that data for use in the prototype website or, potentially, other applications.

The prototype used some sample ONS data. There are [scripts for downloading, converting and populating](https://github.com/ONSdigital/ons-poc-data) a Mongo database with this data.

All of the components are written in Ruby. Both the web application and the data API are simple [Sinatra](http://www.sinatrarb.com/) applications.

The demo version of the site has been deployed to Heroku.

For more detail on the design and implementation of each of the components, consult the repos referenced above.

The rest of this README has some notes on how to deploy the frontend only.

## Application Overview

The frontend is a Sinatra application with templates that use ERB. 

The data used to build the pages is retrieved from the statistical API using [ActiveResource](https://github.com/rails/activeresource) as the client library. This provides a simple (but limited) way to retrieve data from JSON based APIs.

The time series graphs are displayed using the [Rickshaw](http://code.shutterstock.com/rickshaw/) time series charting library.

## Deploying the Frontend

Note: to develop with the front end application you will need to have a copy of the data API deployed, see the [API deployment notes](https://github.com/ONSdigital/ons-data-api#deploying-the-api) in the `ons-data-api` project.

The API could be running locally, to give a complete sandboxed environment. Or several developers could share an API deployed to a shared location.

### Installation

First install the basic dependencies:

* Ruby 2.1
* Ruby gems
* [Bundler](http://bundler.io/)

This provides a basic environment. To install the ruby libraries used in the application run:

```
bundle install
```

This will install all of the necessary dependencies which are listed in the `Gemfile`. 

There are no direct code dependencies between the frontend application and the other components, the application just uses the API to retrieve the required data.

### Running the Application Locally

The application needs to know the location of the API. This is configured using an environment variable `DATA_API_URL`. This needs to be set to the base URL of the API, including the port if necessary. E.g:

```
export DATA_API_URL=http://localhost:3000
```

The application can then be run as a Rack application, using the configuration from `config.ru`:

```
rackup
```

By default this will start the application on `http://localhost:9292`.

### Running the Application on Heroku

All of the configuration is in place to run the application on Heroku. Read the Heroku documentation on deploying Rack based applications and setting environment variables.




