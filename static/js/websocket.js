var socket;
if (!window.WebSocket) {
    window.WebSocket = window.MozWebSocket;
}
// Javascript Websocket Client   
if (window.WebSocket) {
    socket = new WebSocket("ws://" + window.location.host + "/websocket");
    socket.onmessage = function(event) {
        var ta = document.getElementById('responseText');
        //ta.value = ta.value + '\n' + event.data;
        ta.innerHTML = ta.innerHTML + '\n' + event.data;
        document.getElementById("responseText").scrollTop = document.getElementById("responseText").scrollHeight;
    };
    socket.onopen = function(event) {
        var ta = document.getElementById('responseText');
        ta.innerHTML = "<span style='color:green;'> Web Socket opened! </span>";
    };
    socket.onclose = function(event) {
        var ta = document.getElementById('responseText');
        ta.innerHTML = ta.innerHTML + "<br><span style='color:red;'> Web Socket closed! </span>";
    };
} else {

    alert("Your browser does not support Web Socket.");
}
// Send Websocket data   

function send(message) {
    if (!window.WebSocket) {
        return;
    }
    if (socket.readyState == WebSocket.OPEN) {
        socket.send(message);
    } else {
        alert("The socket is not open.");
    }
}

function cleanlog() {
    document.getElementById('responseText').innerHTML = "<span style='color:red;'> 日志已清除! </span>";
}
