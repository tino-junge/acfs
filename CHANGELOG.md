# Changelog

## 0.16.0

* Add YAML configuration
* Add external configuration for services
* Add Rubinius support

## 0.15.0

* Add stubbing capabilities for resources

## 0.14.0 & 0.13.0

* Fix response attributes

## 0.12.0

* Add JRuby support
* Improve handling of error respones (422)

## 0.11.0

* Add Logger Middleware
* Add handling of error responses

## 0.10.0

* Return hash with indifferent access for resource attributes

## 0.9.0

* Add create operation

## 0.8.0

* Add save operation (PUT and POST)
* Add JSON and MessagePack encoder middlewares for encoding request data
* ActiveModel::Dirty
* Add persistant state methods

## 0.7.0

* Per-service middleware stack

## 0.6.0

* Add support for multiple ids for .find
* Add MessagePack support

## 0.5.1

* Fix mime type parsing for mime types with aditional parameters (ActionPack < 4.0)

## 0.5.0

* Add mime type support for respones

## 0.4.0

* Improve JSON response detection
* Add bool attribute type

## 0.3.0

* Add tracking for loading state (if resource is loaded or queued)
* Add JSON middleware to decode respones
* Add middleware support
* Add method to fetch single resources or list of resources
* Use typhoeus as http library for parallel request processing

## 0.2.0

* Allow to define resources and attributes

## 0.1.0

* Project start