import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/controllers/server_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Server",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GetBuilder<ServerController>(
        init: ServerController(),
        builder: (controller) => Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Server",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () async {
                            await controller.startOrStopServer();
                          },
                          child: Text(
                            controller.server!.running
                                ? "Stop Server"
                                : "Start server",
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: controller.server!.running
                                ? Colors.green[400]
                                : Colors.red[400],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              controller.server!.running ? "ON" : "OFF",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    // ListView(
                    //   children:
                    //       controller.serverLogs.map((e) => Text(e)).toList(),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: ColoredBox(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                          decoration: const InputDecoration(
                            labelText: "Enter a message",
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: controller.messageController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: controller.handleMessage,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
