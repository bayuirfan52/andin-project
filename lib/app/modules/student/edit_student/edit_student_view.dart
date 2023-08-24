import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'edit_student_controller.dart';

class EditStudentView extends GetView<EditStudentController> {
  const EditStudentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditStudentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditStudentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
