import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'edit_question_controller.dart';

class EditQuestionView extends GetView<EditQuestionController> {
  const EditQuestionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditQuestionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditQuestionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
