import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/extensions/string_extensions.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/utils/device_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  final teacherController = TextEditingController();
  final currentLocale = 0.obs;
  final isTablet = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = await DeviceUtil.isTablet();
    if (PreferenceHelper.getActiveLanguage().isNullOrEmpty) {
      await PreferenceHelper.setActiveLanguage('id_ID');
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
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_name_field_error'.tr, type: FlushbarType.ERROR);
    }
    PreferenceHelper.setTeachersName(teacherController.text);
    FlushbarHelper.showFlushbar(Get.context!, message: 'text_edit_name_success'.tr, type: FlushbarType.SUCCESS);
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
