import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'student_management_controller.dart';

class StudentManagementView extends GetView<StudentManagementController> {
  const StudentManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentManagementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
