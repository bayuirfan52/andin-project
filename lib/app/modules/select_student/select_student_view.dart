import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'select_student_controller.dart';

class SelectStudentView extends GetView<SelectStudentController> {
  const SelectStudentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectStudentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SelectStudentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
