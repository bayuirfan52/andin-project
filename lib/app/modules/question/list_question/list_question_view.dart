import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Center(
        child:
        ListView.separated(
          itemBuilder: (context, index) => ListTile(
            leading: Checkbox(value: true, onChanged: (value) => {}),
            title: Text(
              'Question $index',
              style: GoogleFonts.aBeeZee(
                fontSize: 24,
              ),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colorBorder),
              borderRadius: BorderRadius.circular(5),
            ),
            onTap: () {},
            trailing: Icon(
              Icons.navigate_next,
            ),
          ),
          separatorBuilder: (context, item) => 12.heightBox,
          itemCount: 8,
        ).pSymmetric(h: 128, v: 24).hFull(context),
      ),
    );
  }
}
