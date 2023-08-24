import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'list_question_controller.dart';

class ListQuestionView extends GetView<ListQuestionController> {
  const ListQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${controller.currentLevel.value}'),
        centerTitle: true,
      ),
      body: VStack(const []),
    );
  }
}
