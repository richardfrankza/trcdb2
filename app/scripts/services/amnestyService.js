'use strict';

/* Services */

var amnestyService = angular.module('amnestyService', ['ngResource']);

amnestyService.factory('AmnestyApplications', ['$resource',
  function($resource){
    return $resource(window.databaseUrl+'amnesty_applications', {}, {
      query: {method:'GET', isArray:true}
    });
  }]);
