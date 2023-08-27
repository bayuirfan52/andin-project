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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        centerTitle: true,
        actions: [
          MaterialButton(
            onPressed: () => controller.goToAddStudent(),
            child: Text(
              'Add New Student',
              textScaleFactor: 1.5,
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: VStack(
          [
            ExTextFieldIcon(
              prefixIcon: Icons.search_rounded,
              hint: 'Search',
              tfController: controller.searchController,
              textAlign: TextAlign.center,
              onChanged: (value) => controller.filter(),
            ),
            24.heightBox,
            Obx(
              () => controller.listStudentFiltered.isEmpty
                  ? EmptyWidget(
                      message: 'Student Not Found',
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
                        onTap: () => controller.goToStudentDetail(),
                        trailing: IconButton(
                          onPressed: () => ExDialog.alertDialog(
                            title: 'Alert',
                            message: 'Are you sure to delete this student?',
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
            )
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).pSymmetric(h: 128, v: 24).hFull(context),
      ),
    );
  }
}
