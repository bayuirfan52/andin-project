import 'package:get/get.dart';

import 'dev_tools_controller.dart';

class DevToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevToolsController>(
      () => DevToolsController(),
    );
  }
}
