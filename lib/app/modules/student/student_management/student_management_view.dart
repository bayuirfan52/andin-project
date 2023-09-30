import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/widgets/empty_widget.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
import 'package:andin_project/app/widgets/ex_textfield_icon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'student_management_controller.dart';

class StudentManagementView extends GetView<StudentManagementController> {
  const StudentManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('text_student_management'.tr),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => controller.goToAddStudent(),
              child: Text(
                'button_add_new_student'.tr,
                textScaleFactor: 1.5,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Center(
          child: VStack(
            [
              ExTextFieldIcon(
                prefixIcon: Icons.search_rounded,
                hint: 'text_search'.tr,
                tfController: controller.searchController,
                textAlign: TextAlign.center,
                onChanged: (value) => controller.filter(),
              ),
              24.heightBox,
              Obx(
                () => controller.listStudentFiltered.isEmpty
                    ? EmptyWidget(
                        message: 'text_student_not_found'.tr,
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            controller.listStudentFiltered[index].studentName ?? '',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 24,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: colorBorder),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onTap: () => controller.goToStudentDetail(controller.listStudentFiltered[index].id ?? ''),
                          trailing: IconButton(
                            onPressed: () => ExDialog.alertDialog(
                              title: 'text_alert'.tr,
                              message: 'text_alert_delete_student'.tr,
                              onConfirmClicked: () => controller.removeStudent(index),
                            ),
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                        separatorBuilder: (context, item) => 12.heightBox,
                        itemCount: controller.listStudentFiltered.length,
                      ).expand(),
              ),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(h: 128, v: 24).hFull(context),
        ),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'text_student_management'.tr,
            style: GoogleFonts.aBeeZee(fontSize: 16),
          ),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => controller.goToAddStudent(),
              child: Text(
                'button_add_new_student'.tr,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Center(
          child: VStack(
            [
              ExTextFieldIcon(
                prefixIcon: Icons.search_rounded,
                hint: 'text_search'.tr,
                size: 12,
                hintSize: 12,
                tfController: controller.searchController,
                textAlign: TextAlign.center,
                onChanged: (value) => controller.filter(),
              ),
              12.heightBox,
              Obx(
                () => controller.listStudentFiltered.isEmpty
                    ? EmptyWidget(
                        message: 'text_student_not_found'.tr,
                        textSize: 12,
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            controller.listStudentFiltered[index].studentName ?? '',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: colorBorder),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          onTap: () => controller.goToStudentDetail(controller.listStudentFiltered[index].id ?? ''),
                          trailing: IconButton(
                            iconSize: 16,
                            onPressed: () => ExDialog.alertDialog(
                              title: 'text_alert'.tr,
                              message: 'text_alert_delete_student'.tr,
                              isTablet: false,
                              onConfirmClicked: () => controller.removeStudent(index),
                            ),
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                        separatorBuilder: (context, item) => 12.heightBox,
                        itemCount: controller.listStudentFiltered.length,
                      ).expand(),
              ),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(h: 128, v: 12).hFull(context),
        ),
      );
}
