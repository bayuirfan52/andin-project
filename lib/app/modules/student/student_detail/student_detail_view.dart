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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => controller.backToDashboard(),
          ),
          title: Text('Detail Student'),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => ExDialog.alertDialog(
                title: 'Alert',
                message: 'Are you sure to delete this student?',
                onConfirmClicked: () => controller.removeStudent(),
              ),
              child: Text(
                'Delete',
                textScaleFactor: 1.5,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
            12.widthBox,
            MaterialButton(
              onPressed: () => controller.goToEditStudent(),
              child: Text(
                'Edit',
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
              HStack([
                24.widthBox,
                Text(
                  'Level',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                  ),
                ),
                Spacer(),
                Text(
                  'Total',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                  ),
                ),
                128.widthBox,
                Text(
                  'Average',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                  ),
                ),
                24.widthBox,
              ]),
              24.heightBox,
              ListTile(
                shape: RoundedRectangleBorder(side: BorderSide(color: colorBorder), borderRadius: BorderRadius.all(Radius.circular(12))),
                contentPadding: EdgeInsets.all(24),
                title: Text(
                  'Level 1',
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                  ),
                ),
                trailing: HStack([
                  Obx(
                    () => Text(
                      controller.level1TotalScore.value.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  164.widthBox,
                  Obx(
                    () => Text(
                      controller.averageLevel1.value.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  24.widthBox,
                ]),
              ),
              24.heightBox,
              ListTile(
                shape: RoundedRectangleBorder(side: BorderSide(color: colorBorder), borderRadius: BorderRadius.all(Radius.circular(12))),
                contentPadding: EdgeInsets.all(24),
                title: Text(
                  'Level 2',
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                  ),
                ),
                trailing: HStack([
                  Obx(
                    () => Text(
                      controller.level2TotalScore.value.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  164.widthBox,
                  Obx(
                    () => Text(
                      controller.averageLevel2.value.toString(),
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  24.widthBox,
                ]),
              ),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).scrollVertical().hFull(context).pSymmetric(v: 24, h: 128),
        ),
      ),
    );
  }
}
