import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'question_detail_controller.dart';

class QuestionDetailView extends GetView<QuestionDetailController> {
  const QuestionDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuestionDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
