'use strict';

/**
* @ngdoc overview
* @name trcdbApp
* @description
* # trcdbApp
*
* Main module of the application.
*/
angular
.module('trcdbApp', [
   'ngAnimate',
   'ngAria',
   'ngCookies',
   'ngMessages',
   'ngResource',
   'ngRoute',
   'ngSanitize'
])
.config(function ($routeProvider, $locationProvider) {
   $locationProvider.hashPrefix(''); // AngularJS 1.6 set hash prefix of '!' by default, so remove it.
   $routeProvider
   .when('/', {
      templateUrl: 'scripts/modules/main/main.html',
      controller: 'MainCtrl',
      controllerAs: 'main'
   })
   .when('/statements', {
      templateUrl: 'scripts/modules/statements/statements.html',
      controller: 'StatementsCtrl',
      controllerAs: 'statements'
   })
   .when('/amnesty', {
      templateUrl: 'scripts/modules/amnesty/amnesty.html',
      controller: 'AmnestyCtrl',
      controllerAs: 'amnesty'
   })
   .when('/acts', {
      templateUrl: 'scripts/modules/acts/acts.html',
      controller: 'ActsCtrl',
      controllerAs: 'acts'
   })
   .when('/maps', {
      templateUrl: 'scripts/modules/maps/maps.html',
      controller: 'MapsCtrl',
      controllerAs: 'maps'
   })
   .when('/victims', {
      templateUrl: 'scripts/modules/victims/victims.html',
      controller: 'VictimsCtrl',
      controllerAs: 'victims'
   })
   .when('/perpetrators', {
      templateUrl: 'scripts/modules/perpetrators/perpetrators.html',
      controller: 'PerpetratorsCtrl',
      controllerAs: 'perpetrators'
   })
   .when('/witnesses', {
      templateUrl: 'scripts/modules/witnesses/witnesses.html',
      controller: 'WitnessesCtrl',
      controllerAs: 'witnesses'
   })
   .when('/history', {
      templateUrl: 'scripts/modules/history/history.html',
      controller: 'HistoryCtrl',
      controllerAs: 'history'
   })
   .when('/howto', {
      templateUrl: 'scripts/modules/howto/howto.html',
      controller: 'HowtoCtrl',
      controllerAs: 'howto'
   })
   .when('/glossary', {
      templateUrl: 'scripts/modules/glossary/glossary.html',
      controller: 'GlossaryCtrl',
      controllerAs: 'glossary'
   })
   .otherwise({
      redirectTo: '/'
   });
});
