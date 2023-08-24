import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const _TEACHER_NAME = 'TEACHER_NAME';
const _CURRENT_ACTIVE_STUDENT = 'CURRENT_ACTIVE_STUDENT';

mixin PreferenceHelper {
  static final _pref = Get.find<GetStorage>();

  static void resetData() => _pref.erase();
  static void deleteData(String key) => _pref.remove(key);

  static Future<void> setTeachersName(String name) async {
    await _pref.write(_TEACHER_NAME, name);
  }

  static String? getTeacherName() => _pref.read(_TEACHER_NAME) as String?;

  static Future<void> setCurrentActiveStudent(String? id) async {
    await _pref.write(_CURRENT_ACTIVE_STUDENT, id);
  }

  static String? getCurrentActiveStudent() => _pref.read(_CURRENT_ACTIVE_STUDENT) as String?;

  static String getCurrentAppName() => FlutterConfig.get('APP_NAME').toString();
}
