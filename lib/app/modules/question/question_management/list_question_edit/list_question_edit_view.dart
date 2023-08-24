import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'list_question_edit_controller.dart';

class ListQuestionEditView extends GetView<ListQuestionEditController> {
  const ListQuestionEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListQuestionEditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ListQuestionEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
