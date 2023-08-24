import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/widgets/ex_button_default.dart';
import 'package:andin_project/app/widgets/ex_textfield_icon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'select_student_controller.dart';

class SelectStudentView extends GetView<SelectStudentController> {
  const SelectStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.goToAddStudent(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ).pOnly(right: 128),
      body: Center(
        child: VStack(
          [
            Text(
              'Select Student',
              style: GoogleFonts.aBeeZee(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            24.heightBox,
            ExTextFieldIcon(
              prefixIcon: Icons.search_rounded,
              hint: 'Search',
              tfController: controller.searchController,
              textAlign: TextAlign.center,
            ),
            24.heightBox,
            ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: Obx(() => Checkbox(value: controller.selectedIndex.value == index, onChanged: (value) => {})),
                title: Text(
                  'Student $index',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: controller.selectedIndex.value == index ? colorPrimary : colorBorder),
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () {
                  controller.selectedIndex.value = index;
                },
              ),
              separatorBuilder: (context, item) => 12.heightBox,
              itemCount: 8,
            ).expand()
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).pSymmetric(h: 128, v: 24).hFull(context),
      ),
      bottomNavigationBar: ExButtonDefault(
        label: 'Enter',
        labelSize: 32,
        height: 64,
        onPressed: () => controller.goToDashboard(),
      ).wFull(context).pOnly(right: 128, left: 128, top: 24, bottom: 48),
    );
  }
}
