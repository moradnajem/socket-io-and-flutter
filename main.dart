import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';



void main() {
  runApp(MaterialApp(
    home: socket(),
    debugShowCheckedModeBanner: false,
  ));
}


class socket extends StatefulWidget {
  @override
  _socketState createState() => _socketState();
}

class _socketState extends State<socket> {

  String URI = "http://10.0.2.2:5050";
  SocketIOManager manager;
  SocketIO socket;
  var msg = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    manager = SocketIOManager();
    initSocket();
  }

  initSocket() async {
    socket = await manager.createInstance(
        SocketOptions(URI, enableLogging: false, query: {"uid": "1"}));
    socket.onConnect((data) {
      print("Conected ....");
    });
    socket.on("msg", (data) {
      print("${data["message"]}" + "-----");
      setState(() {
        msg = data["message"];
        print("$msg" + "*****");
      });
    });
    socket.connect();
  }


  send(var msg){
    socket.emit("msg",[{
      "message": "$msg",
      "room": "1",
      "name" : "morad"
    }]
    );
  }



  disconnect(){
    manager.clearInstance(socket);
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Send"),
              onPressed: (){
                send("hello flutter111");
              },
            ),
            Text("$msg"),
            RaisedButton(
              child: Text("disconnect"),
              onPressed: (){
                disconnect();
              },
            ),
            RaisedButton(
              child: Text("connect"),
              onPressed: (){
                initSocket();
              },
            )
          ],
        ),
      ),
    );
  }
}
