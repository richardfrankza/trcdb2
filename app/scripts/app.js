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
   .when('/help', {
      templateUrl: 'scripts/modules/help/help.html',
      controller: 'HelpCtrl',
      controllerAs: 'help'
   })
   .otherwise({
      redirectTo: '/'
   });
});
