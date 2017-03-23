'use strict';

/**
* @ngdoc function
* @name trcdbApp.controller:AmnestyCtrl
* @description
* # AmnestyCtrl
* Controller of the trcdbApp
*/
angular.module('trcdbApp')
.controller('AmnestyCtrl', ['$scope', '$filter', 'AmnestyApplications', function($scope, $filter, AmnestyApplications) {
   $scope.rowCollection = AmnestyApplications.query();
}]);
