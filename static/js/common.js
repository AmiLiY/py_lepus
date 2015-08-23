// Code goes here
var DEMO = angular.module("myApp", []);

DEMO.config(function($interpolateProvider) {
    $interpolateProvider.startSymbol('[[');
    $interpolateProvider.endSymbol(']]');
});

var pathname = window.location.pathname;
DEMO.controller('mainCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.status = {};
    $scope.itemsPerPage = 10;
    $scope.currentPage = 0;
    $scope.clickFilter = false;
    $http.post(pathname, window.location.search).then(function(result) {
        $scope.data = result.data;
    });

    $scope.statusFilter = function(col, value) {
        if ($scope.clickFilter){
            $scope.status[col] = value;
        }
    };

    $scope.flush = function() {
        $http.post(pathname, window.location.search).then(function(result) {
            $scope.data = result.data;
        });
    };
    $scope.reset = function() {
        $scope.status = {};
        $scope.searchText = '';
    };
    $scope.prevPage = function() {
        if ($scope.currentPage > 0) {
            $scope.currentPage--;
        }
    };

    $scope.setPerPage = function(n) {
        if (($scope.currentPage + 1) * n > $scope.data.length) {

            $scope.currentPage = 0;
        }
        $scope.itemsPerPage = n;
    }

    $scope.range = function(n) {
        var arrRange = [];
        for (i = 0; i < n; i++) {
            arrRange.push(i);

        }
        return arrRange;
    }
    $scope.setPage = function(n) {
        $scope.currentPage = n;
    }
    $scope.prevPageDisabled = function() {
        return $scope.currentPage === 0 ? "disabled" : "";
    };

    $scope.pageCount = function() {
        if (!$scope.data || !$scope.data.length) {
            return;
        }
        return Math.ceil($scope.data.length / $scope.itemsPerPage);
    };

    $scope.nextPage = function() {
        if ($scope.currentPage+1 < $scope.pageCount()) {
            $scope.currentPage++;
        }
    };

    $scope.nextPageDisabled = function() {
        return $scope.currentPage+1 === $scope.pageCount() ? "disabled" : "";
    }
}]);

DEMO.filter('offset', function() {
    return function(input, start) {
        if (!input || !input.length) {
            return;
        }
        start = parseInt(start, 10);
        return input.slice(start);
    };
});
$(function() {
    $("button").tooltip();
});