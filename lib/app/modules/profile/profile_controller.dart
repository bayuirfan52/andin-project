import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/extensions/string_extensions.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  final teacherController = TextEditingController();
  final currentLocale = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (PreferenceHelper.getActiveLanguage().isNullOrEmpty) {
      PreferenceHelper.setActiveLanguage('id_ID');
    }
    currentLocale.value = PreferenceHelper.getActiveLanguage() == 'id_ID' ? 0 : 1;
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

  void changeLanguage(int? index) {
    currentLocale.value = index ?? 0;
    switch (index) {
      case 0:
        Get.updateLocale(Locale('id', 'ID'));
        PreferenceHelper.setActiveLanguage('id_ID');
        break;
      case 1:
        Get.updateLocale(Locale('en', 'US'));
        PreferenceHelper.setActiveLanguage('en_US');
        break;
      default:
    }
  }
}
