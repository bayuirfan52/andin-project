import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  final teacherController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    teacherController.text = PreferenceHelper.getTeacherName() ?? '';
  }

  @override
  void onClose() {
    super.onClose();
  }

  void saveNewName() {
    if (teacherController.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: "Name can't be empty", type: FlushbarType.ERROR);
    }
    PreferenceHelper.setTeachersName(teacherController.text);
    FlushbarHelper.showFlushbar(Get.context!, message: 'Change Name Success', type: FlushbarType.SUCCESS);
  }
}
