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

## Application Overview

The application is made up of three components:

* The prototype website (this repo)
* A [statistical data API](https://github.com/ONSdigital/ons-data-api) which provides access to the raw data
* Some [domain objects capturing the data model](https://github.com/ONSdigital/ons_data_models) used in the API

The application is intended to be backed by a Mongo database which stores the underlying statistical data. The API provides views over that data for use in the prototype website or, potentially, other applications.

The prototype used some sample ONS data. There are [scripts for downloading, converting and populating](https://github.com/ONSdigital/ons-poc-data) a Mongo database with this data.

All of the components are written in Ruby. The demo version of the site has been deployed to Heroku.







