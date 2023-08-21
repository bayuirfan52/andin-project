import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

mixin PreferenceHelper {
  static final _pref = Get.find<GetStorage>();

  static void resetData() => _pref.erase();
  static void deleteData(String key) => _pref.remove(key);
}
