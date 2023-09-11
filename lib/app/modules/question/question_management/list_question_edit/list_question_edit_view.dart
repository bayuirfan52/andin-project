import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/widgets/empty_widget.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'list_question_edit_controller.dart';

class ListQuestionEditView extends GetView<ListQuestionEditController> {
  const ListQuestionEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTablet.isTrue ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit : ${controller.currentLevel.value == 1 ? 'PECS 1 & 2' : 'PECS 3A & 3B 1'}'),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => controller.goToAddQuestion(),
              child: Text(
                'button_add_new_question'.tr,
                textScaleFactor: 1.5,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            )
          ],
        ),
        body: Center(
          child: Obx(() => controller.currentLevel.value == 1 ? listLevel1(context) : listLevel2(context)),
        ),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit : ${controller.currentLevel.value == 1 ? 'PECS 1 & 2' : 'PECS 3A & 3B 1'}',
            style: GoogleFonts.aBeeZee(fontSize: 16),
          ),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => controller.goToAddQuestion(),
              child: Text(
                'button_add_new_question'.tr,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            )
          ],
        ),
        body: Center(
          child: Obx(() => controller.currentLevel.value == 1 ? listLevel1(context) : listLevel2(context)),
        ),
      );

  Widget listLevel1(BuildContext context) => Obx(
        () => controller.listLevel1.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  final item = controller.listLevel1[index];
                  return ListTile(
                    title: Text(
                      item.question ?? '',
                      style: GoogleFonts.aBeeZee(
                        fontSize: controller.isTablet.isTrue ? 24 : 12,
                      ),
                    ),
                    dense: controller.isTablet.isFalse,
                    visualDensity: controller.isTablet.isFalse ? VisualDensity.compact : VisualDensity.standard,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorBorder),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: () => controller.goToEditQuestion(item.id ?? ''),
                    trailing: IconButton(
                      onPressed: () => ExDialog.alertDialog(
                        title: 'text_alert'.tr,
                        message: 'text_alert_delete_question'.tr,
                        onConfirmClicked: () => controller.removeQuestion(item.id ?? ''),
                      ),
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, item) => 12.heightBox,
                itemCount: controller.listLevel1.length,
              ).pSymmetric(h: 128, v: 24).hFull(context)
            : EmptyWidget(
                message: 'text_question_not_found'.tr,
                textSize: controller.isTablet.isTrue ? 24 : 12,
              ),
      );

  Widget listLevel2(BuildContext context) => Obx(
        () => controller.listLevel2.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  final item = controller.listLevel2[index];
                  return ListTile(
                    title: Text(
                      item.question ?? '',
                      style: GoogleFonts.aBeeZee(
                        fontSize: controller.isTablet.isTrue ? 24 : 12,
                      ),
                    ),
                    dense: controller.isTablet.isFalse,
                    visualDensity: controller.isTablet.isFalse ? VisualDensity.compact : VisualDensity.standard,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorBorder),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: () => controller.goToEditQuestion(item.id ?? ''),
                    trailing: IconButton(
                      onPressed: () => ExDialog.alertDialog(
                        title: 'text_alert'.tr,
                        message: 'text_question_not_found'.tr,
                        onConfirmClicked: () => controller.removeQuestion(item.id ?? ''),
                      ),
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, item) => 12.heightBox,
                itemCount: controller.listLevel2.length,
              ).pSymmetric(h: 128, v: 24).hFull(context)
            : EmptyWidget(
                message: 'text_question_not_found'.tr,
                textSize: controller.isTablet.isTrue ? 24 : 12,
              ),
      );
}
