import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddStudentController extends GetxController {
  final studentController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
