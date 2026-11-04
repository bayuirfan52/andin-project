import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/extensions/string_extensions.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  final teacherController = TextEditingController();
  final RxInt currentLocale = 0.obs;
  final RxBool isTablet = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = PreferenceHelper.isTablet();
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

  Future<void> saveNewName() async {
    if (teacherController.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_name_field_error'.tr, type: FlushbarType.ERROR);
    }
    await PreferenceHelper.setTeachersName(teacherController.text);
    FlushbarHelper.showFlushbar(Get.context!, message: 'text_edit_name_success'.tr, type: FlushbarType.SUCCESS);
  }

  Future<void> changeLanguage(int? index) async {
    currentLocale.value = index ?? 0;
    switch (index) {
      case 0:
        await Get.updateLocale(Locale('id', 'ID'));
        await PreferenceHelper.setActiveLanguage('id_ID');
      case 1:
        await Get.updateLocale(Locale('en', 'US'));
        await PreferenceHelper.setActiveLanguage('en_US');
      default:
    }
  }
}
