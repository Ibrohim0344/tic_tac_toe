import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../server/server.dart';

class ServerController extends GetxController {
  Server? server;
  List<String> serverLogs = [];
  final messageController = TextEditingController();

  @override
  void onInit() {
    server = Server(onData, onError);
    startOrStopServer();
    super.onInit();
  }

  Future<void> startOrStopServer() async {
    if (server!.running) {
      await server!.close();
      serverLogs.clear();
    } else {
      await server!.start();
    }
    update();
  }

  void onData(Uint8List data) {
    final receivedData = String.fromCharCodes(data);
    serverLogs.add(receivedData);
    update();
  }

  void onError(dynamic error) {
    debugPrint("=============");
    debugPrint("Error: $error");
    debugPrint("=============");
  }

  void handleMessage() {
    server!.broadcast(messageController.text);
    // serverLogs.add(messageController.text);
    messageController.clear();
    update();
  }
}
