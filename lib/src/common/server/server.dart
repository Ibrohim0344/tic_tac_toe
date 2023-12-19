import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

typedef Unit8ListCallBack = Function(Uint8List data);
typedef DynamicCallBack = Function(dynamic data);

class Server {
  Unit8ListCallBack? onData;
  DynamicCallBack? onError;

  Server(this.onData, this.onError);

  ServerSocket? server;
  bool running = false;
  List<Socket> sockets = [];

  Future<void> start() async {
    runZoned(() async {
      server = await ServerSocket.bind("192.168.0.105", 4000);
      running = true;
      server!.listen(onRequest);
      const message = "Server is listening in port 4000";
      onData!(Uint8List.fromList(message.codeUnits));
    }, onError: onError);
  }

  Future<void> close() async {
    await server!.close();
    server = null;
    running = false;
  }

  void onRequest(Socket socket) {
    if (!sockets.contains(socket)) sockets.add(socket);
    socket.listen((event) {
      onData!(event);
    });
  }

  void broadcast(String data) {
    onData!(Uint8List.fromList("Broadcast message: $data".codeUnits));
    for (final socket in sockets) {
      socket.write(data);
    }
  }
}
