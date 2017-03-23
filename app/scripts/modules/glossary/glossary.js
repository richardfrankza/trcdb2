'use strict';

/**
* @ngdoc function
* @name trcdbApp.controller:GlossaryCtrl
* @description
* # GlossaryCtrl
* Controller of the trcdbApp
*/
angular.module('trcdbApp')
.controller('GlossaryCtrl', ['$scope', function ($scope) {
   $scope.rows = [
      {term: 'Deponent', definition: 'A person making a statement about a violation of Human Rights.'},
      {term: 'Perpetrator', definition: 'A person who has carried out a harmful, illegal, or immoral act.'},
      {term: 'Amnesty application', definition: 'An application for amnesty in respect of any act, omission or offence on the grounds that it is an act associated with a political objective.'}
    ];
}]);
