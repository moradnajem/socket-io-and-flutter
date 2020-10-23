var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);


				io.on('connection', function(socket){
				console.log('NEW USER CONNECTED !');
				var myroom = socket.handshake.query.uid;
				console.log(myroom);
				socket.join(myroom);


				socket.on('disconnect', () => {
				console.log('USER DISCONNECTED !');
				socket.leave(myroom);
				})
				socket.on('msg', function(data) {
				console.log("Success______________________. ✔");
				io.sockets.in(myroom).emit('msg',{message: data.message,room: data.room,name :data.name});	    			    		
				});
				});






http.listen(5050, function(){
console.log('💥 YOUR WEBSOCKET IS RUNING 💥');
});






