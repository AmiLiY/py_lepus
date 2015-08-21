// Code goes here
var DEMO = angular.module("myApp", []);
 
DEMO.config(function($interpolateProvider) {
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');
});

var pathname = window.location.pathname;
DEMO.controller('mainCtrl',['$scope', '$http', function($scope,$http){
    $scope.status = {};

    $http.post(pathname,window.location.search).then(function (result) {
        $scope.data = result.data;
    });

    $scope.statusFilter = function(col,value){
        $scope.status[col]=value;
    };

    $scope.flush = function(){
        $http.post(pathname,window.location.search).then(function (result) {
            $scope.data = result.data;
        });
    };
    $scope.reset = function(){
        $scope.status = {};
        $scope.searchText = '';
    };
}]);

$(function(){
            $("button").tooltip();
        });
