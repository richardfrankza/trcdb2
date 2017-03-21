'use strict';

/**
* @ngdoc overview
* @name trcdb2App
* @description
* # trcdb2App
*
* Main module of the application.
*/
angular
.module('trcdb2App', [
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
      templateUrl: 'views/main.html',
      controller: 'MainCtrl',
      controllerAs: 'main'
   })
   .when('/about', {
      templateUrl: 'views/about.html',
      controller: 'AboutCtrl',
      controllerAs: 'about'
   })
   .otherwise({
      redirectTo: '/'
   });
});
