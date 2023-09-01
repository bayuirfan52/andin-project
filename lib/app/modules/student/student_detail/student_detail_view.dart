import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'student_detail_controller.dart';

class StudentDetailView extends GetView<StudentDetailController> {
  const StudentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.backToDashboard();
        return true;
      },
      child: Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context)),
    );
  }

  Widget tabletUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => controller.backToDashboard(),
          ),
          title: Text('text_detail_student'.tr),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => ExDialog.alertDialog(
                title: 'text_alert'.tr,
                message: 'text_alert_delete_student'.tr,
                onConfirmClicked: () => controller.removeStudent(),
              ),
              child: Text(
                'button_delete'.tr,
                textScaleFactor: 1.5,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
            12.widthBox,
            MaterialButton(
              onPressed: () => controller.goToEditStudent(),
              child: Text(
                'button_edit'.tr,
                textScaleFactor: 1.5,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Center(
          child: VStack(
            [
              Obx(
                () => Text(
                  controller.student.value.studentName ?? '',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              128.heightBox,
              DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Level',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'text_average'.tr,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          'Level 1',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.level1TotalScore.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.averageLevel1.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          'Level 2',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.level2TotalScore.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.averageLevel2.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ).wFull(context),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).scrollVertical().hFull(context).pSymmetric(v: 24, h: 128),
        ),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => controller.backToDashboard(),
          ),
          title: Text(
            'text_detail_student'.tr,
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => ExDialog.alertDialog(
                title: 'text_alert'.tr,
                message: 'text_alert_delete_student'.tr,
                onConfirmClicked: () => controller.removeStudent(),
                isTablet: false,
              ),
              child: Text(
                'button_delete'.tr,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
            12.widthBox,
            MaterialButton(
              onPressed: () => controller.goToEditStudent(),
              child: Text(
                'button_edit'.tr,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Center(
          child: VStack(
            [
              Obx(
                () => Text(
                  controller.student.value.studentName ?? '',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              12.heightBox,
              DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Level',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'text_average'.tr,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          'Level 1',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.level1TotalScore.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.averageLevel1.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          'Level 2',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.level2TotalScore.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Obx(
                          () => Text(
                            controller.averageLevel2.value.toString(),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ).wFull(context),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).scrollVertical().hFull(context).pSymmetric(v: 24, h: 128),
        ),
      );
}
