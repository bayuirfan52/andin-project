import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/widgets/empty_widget.dart';
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
        actions: [
          MaterialButton(
            onPressed: () => controller.goToSelectStudent(),
            child: Text(
              'Select Student',
              textScaleFactor: 1.5,
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: Obx(
          () => controller.currentLevel.value == 1 ? listLevel1(context) : listLevel2(context),
        ),
      ),
      bottomNavigationBar: HStack(
        [
          Text(
            'Current Active Student : ',
            style: GoogleFonts.aBeeZee(fontSize: 24),
          ),
          Obx(
            () => Text(
              controller.currentStudent.value.studentName ?? '',
              style: GoogleFonts.aBeeZee(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
        alignment: MainAxisAlignment.center,
      ).p24(),
    );
  }

  Widget listLevel1(BuildContext context) => Obx(
        () => controller.listLevel1.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  final item = controller.listLevel1[index];
                  return ListTile(
                    leading: Obx(() => Checkbox(value: controller.listAnswer.where((element) => element.idQuestion == item.id).isNotEmpty, onChanged: (value) => {})),
                    title: Text(
                      item.question ?? '',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorBorder),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: () => controller.goToQuestionDetail(item.id ?? ''),
                    trailing: Icon(
                      Icons.navigate_next,
                    ),
                  );
                },
                separatorBuilder: (context, item) => 12.heightBox,
                itemCount: controller.listLevel1.length,
              ).pSymmetric(h: 128, v: 24).hFull(context)
            : EmptyWidget(
                message: 'Question Not Found',
              ),
      );

  Widget listLevel2(BuildContext context) => Obx(
        () => controller.listLevel2.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  final item = controller.listLevel2[index];
                  return ListTile(
                    leading: Obx(() => Checkbox(value: controller.listAnswer.where((element) => element.idQuestion == item.id).isNotEmpty, onChanged: (value) => {})),
                    title: Text(
                      item.question ?? '',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorBorder),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: () => controller.goToQuestionDetail(item.id ?? ''),
                    trailing: Icon(
                      Icons.navigate_next,
                    ),
                  );
                },
                separatorBuilder: (context, item) => 12.heightBox,
                itemCount: controller.listLevel2.length,
              ).pSymmetric(h: 128, v: 24).hFull(context)
            : EmptyWidget(
                message: 'Question Not Found',
              ),
      );
}
