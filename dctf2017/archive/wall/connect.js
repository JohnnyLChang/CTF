var io = require('socket.io');
var socket = io.connect('http://localhost:8081');
socket.on('connection', function () {
    socket.emit('addme', prompt('Who are you?'));
});