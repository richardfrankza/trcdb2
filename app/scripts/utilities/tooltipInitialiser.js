'use strict';
/**
 * @ngdoc overview
 * @name tooltipInitialiser
 * @description
 * # trcdbApp
 *
 * Initialise Bootstrap tooltips.
 */
$(document).ready(function() {
   $("body").tooltip({ selector: '[data-toggle=tooltip]' });
});
