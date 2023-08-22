import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'dev_tools_controller.dart';

class DevToolsView extends GetView<DevToolsController> {
  const DevToolsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Development Tools'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DevToolsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
