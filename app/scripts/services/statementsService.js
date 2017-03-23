'use strict';

/* Services */

var statementsService = angular.module('statementsService', ['ngResource']);

statementsService.factory('ViolationStatements', ['$resource',
  function($resource){
    return $resource(window.databaseUrl+'violation_statements', {}, {
      query: {method:'GET', isArray:true}
    });
  }]);
