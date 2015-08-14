// Code goes here
var DEMO = angular.module("myApp", []);
 
DEMO.config(function($interpolateProvider) {
  $interpolateProvider.startSymbol('//');
  $interpolateProvider.endSymbol('//');
});

var pathname = window.location.pathname;
console.log("")
// console.log($.param({"ip":"123"}))
DEMO.controller('mainCtrl',['$scope', '$http', function($scope,$http){
    $scope.status = 0;

    $http.post(pathname,window.location.search).then(function (result) {
        //console.log(result)
        $scope.data = result.data;
    });

    $scope.statusFilter = function(value){
        $scope.status = {status:value};
    };

    $scope.threadStateFilter = function(value){
        $scope.status = {threadState:value};
    };

    $scope.payFilter = function(value){
        $scope.status = {pay:value};
    };

    $scope.typeFilter = function(value){
        $scope.status = {type:value};
    };

    $scope.envFilter = function(value){
        $scope.status = {env:value};
    };

    $scope.groupFilter = function(value){
        $scope.status = {group:value};
    };

    $scope.showAdviceDetail = function(advicevalue){
        console.log(advicevalue);
        //Ext.Msg.show({title:'堆栈信息',msg:advicevalue,closable:true});
        //Ext.Msg.alert('堆栈信息',advicevalue);
        alert(advicevalue);
        //Ext.Msg.prompt('堆栈信息',advicevalue,function(e,text){alert(e+"-"+text);},this,true);
    };
    $scope.alertMsg = function(msg, mode) {
        msg = msg || '';
        mode = mode || 0;
        var top = document.body.scrollTop || document.documentElement.scrollTop;
        var isIe = (document.all) ? true : false;
        var isIE6 = isIe && !window.XMLHttpRequest;
        var sTop = document.documentElement.scrollTop || document.body.scrollTop;
        var sLeft = document.documentElement.scrollLeft || document.body.scrollLeft;
        var winSize = function(){
            var xScroll, yScroll, windowWidth, windowHeight, pageWidth, pageHeight;
            // innerHeight获取的是可视窗口的高度，IE不支持此属性
            if (window.innerHeight && window.scrollMaxY) {
                xScroll = document.body.scrollWidth;
                yScroll = window.innerHeight + window.scrollMaxY;
            } else if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac
                xScroll = document.body.scrollWidth;
                yScroll = document.body.scrollHeight;
            } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
                xScroll = document.body.offsetWidth;
                yScroll = document.body.offsetHeight;
            }

            if (self.innerHeight) {    // all except Explorer
                windowWidth = self.innerWidth;
                windowHeight = self.innerHeight;
            } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
                windowWidth = document.documentElement.clientWidth;
                windowHeight = document.documentElement.clientHeight;
            } else if (document.body) { // other Explorers
                windowWidth = document.body.clientWidth;
                windowHeight = document.body.clientHeight;
            }

            // for small pages with total height less then height of the viewport
            if (yScroll < windowHeight) {
                pageHeight = windowHeight;
            } else {
                pageHeight = yScroll;
            }

            // for small pages with total width less then width of the viewport
            if (xScroll < windowWidth) {
                pageWidth = windowWidth;
            } else {
                pageWidth = xScroll;
            }

            return{
                'pageWidth':pageWidth,
                'pageHeight':pageHeight,
                'windowWidth':windowWidth,
                'windowHeight':windowHeight
            }
        }();
        //alert(winSize.pageWidth);
        //遮罩层
        var styleStr = 'top:0;left:0;position:absolute;z-index:10000;background:#666;width:' + winSize.pageWidth + 'px;height:' +  (winSize.pageHeight + 30) + 'px;';
        styleStr += (isIe) ? "filter:alpha(opacity=80);" : "opacity:0.8;"; //遮罩层DIV
        var shadowDiv = document.createElement('div'); //添加阴影DIV
        shadowDiv.style.cssText = styleStr; //添加样式
        shadowDiv.id = "shadowDiv";
        //如果是IE6则创建IFRAME遮罩SELECT
        if (isIE6) {
            var maskIframe = document.createElement('iframe');
            maskIframe.style.cssText = 'width:' + winSize.pageWidth + 'px;height:' + (winSize.pageHeight + 30) + 'px;position:absolute;visibility:inherit;z-index:-1;filter:alpha(opacity=0);';
            maskIframe.frameborder = 0;
            maskIframe.src = "about:blank";
            shadowDiv.appendChild(maskIframe);
        }
        document.body.insertBefore(shadowDiv, document.body.firstChild); //遮罩层加入文档
        //弹出框
        var styleStr1 = 'display:block;position:fixed;_position:absolute;left:' + (winSize.windowWidth / 2 - 400) + 'px;top:' + (winSize.windowHeight / 2 - 350) + 'px;_top:' + (winSize.windowHeight / 2 + top - 350)+ 'px;'; //弹出框的位置

        var alertBox = document.createElement('div');
        alertBox.id = 'alertMsg';
        alertBox.style.cssText = styleStr1;
        //创建按钮
        var btn1 = document.createElement('a');
        btn1.id = 'alertMsg_btn1';
        btn1.href = 'javas' + 'cript:void(0)';
        btn1.innerHTML = '<cite>确定</cite>';
        btn1.onclick = function () {
            document.body.removeChild(alertBox);
            document.body.removeChild(shadowDiv);
            return true;
        };
        alertBox.appendChild(btn1);
        //创建弹出框里面的内容P标签
        var alertMsg_info = document.createElement('P');
        alertMsg_info.id = 'alertMsg_info';
        alertMsg_info.innerText = msg;
        alertBox.appendChild(alertMsg_info);
        //创建按钮
        var btn1 = document.createElement('a');
        btn1.id = 'alertMsg_btn1';
        btn1.href = 'javas' + 'cript:void(0)';
        btn1.innerHTML = '<cite>确定</cite>';
        btn1.onclick = function () {
            document.body.removeChild(alertBox);
            document.body.removeChild(shadowDiv);
            return true;
        };
        alertBox.appendChild(btn1);
        if (mode === 1) {
            var btn2 = document.createElement('a');
            btn2.id = 'alertMsg_btn2';
            btn2.href = 'javas' + 'cript:void(0)';
            btn2.innerHTML = '<cite>取消</cite>';
            btn2.onclick = function () {
                document.body.removeChild(alertBox);
                document.body.removeChild(shadowDiv);
                return false;
            };
            alertBox.appendChild(btn2);
        }
        document.body.appendChild(alertBox);

    }

    $scope.reset = function(){
        $scope.status = '';
        $scope.searchText = '';
    };
}]);

$(function(){
            $("button").tooltip();
        });
