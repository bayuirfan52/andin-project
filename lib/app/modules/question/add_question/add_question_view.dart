import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'add_question_controller.dart';

class AddQuestionView extends GetView<AddQuestionController> {
  const AddQuestionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddQuestionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddQuestionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
