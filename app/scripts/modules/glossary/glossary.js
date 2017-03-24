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
      {term: 'Amnesty application', definition: 'An application for amnesty in respect of any act, omission or offence on the grounds that it is an act associated with a political objective.'},
      {term: 'Deponent', definition: 'A person making a statement about a violation of human rights.'},
      {term: 'Gross violation of human rights', definition: 'The violation of human rights through (a) the killing, abduction, torture or severe ill-treatment of any person; or (b) any attempt, conspiracy, incitement, instigation, command or procurement to commit an act referred to in paragraph (a).'},
      {term: 'Perpetrator', definition: 'A person who has carried out a harmful, illegal, or immoral act.'},
      {term: 'Reparation', definition: 'Any form of compensation, ex gratia payment, restitution, rehabilitation or recognition.'},
      {term: 'Victim', definition: 'Victims are (a) persons who, individually or together with one or more persons, suffered harm in the form of physical or mental injury, emotional suffering, pecuniary loss or a substantial impairment of human rights (i) as a result of a gross violation of human rights; or (ii) as a result of an act associated with a political objective for which amnesty has been granted; (b) persons who, individually or together with one or more persons, suffered harm in the form of physical or mental injury, emotional suffering, pecuniary loss or a substantial impairment of human rights, as a result of such person intervening to assist persons contemplated in paragraph (a) who were in distress or to prevent victimization of such persons; and (c) such relatives or dependants of victims as may be prescribed.'}
];
}]);
