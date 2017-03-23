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
   $scope.rows = AmnestyApplications.query();
   $scope.gridOptions = {
      data: 'rows',
      columnDefs: [
         { name: 'reference_no', width: '20%' },
         { name: 'first_names', width: '15%' },
         { name: 'last_name', width: '13%'}
      ],
   };
}]);
