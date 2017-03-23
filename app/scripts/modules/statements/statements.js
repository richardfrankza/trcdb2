'use strict';

/**
* @ngdoc function
* @name trcdbApp.controller:StatementsCtrl
* @description
* # StatementsCtrl
* Controller of the trcdbApp
*/
angular.module('trcdbApp')
.controller('StatementsCtrl', ['$scope', '$filter', 'ViolationStatements', function($scope, $filter, ViolationStatements) {
   $scope.rowCollection = ViolationStatements.query();
}]);
