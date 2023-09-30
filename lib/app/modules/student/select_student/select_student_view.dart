import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/widgets/empty_widget.dart';
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
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) => Scaffold(
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
                'button_select_student'.tr,
                style: GoogleFonts.aBeeZee(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              24.heightBox,
              Obx(
                () => controller.listStudent.isNotEmpty
                    ? ExTextFieldIcon(
                        prefixIcon: Icons.search_rounded,
                        hint: 'text_search'.tr,
                        tfController: controller.searchController,
                        textAlign: TextAlign.center,
                        onChanged: (value) => controller.filter(),
                      )
                    : Container(),
              ),
              24.heightBox,
              Obx(
                () => controller.listStudentFiltered.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                          leading: Obx(() => Checkbox(value: controller.selectedIndex.value == index, onChanged: (value) => {})),
                          title: Text(
                            controller.listStudentFiltered[index].studentName ?? '',
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
                        itemCount: controller.listStudentFiltered.length,
                      ).expand()
                    : EmptyWidget(
                        message: 'text_student_not_found'.tr,
                      ).scrollVertical().expand(),
              ),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(h: 128, v: 24).hFull(context),
        ),
        bottomNavigationBar: Obx(
          () => ExButtonDefault(
            label: 'button_enter'.tr,
            labelSize: 32,
            height: 64,
            isEnable: controller.listStudentFiltered.isNotEmpty,
            onPressed: () => controller.listStudentFiltered.isEmpty ? null : controller.selectCurrentActiveStudent(),
          ).wFull(context).pOnly(right: 128, left: 128, top: 24, bottom: 48),
        ),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
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
                'button_select_student'.tr,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              8.heightBox,
              Obx(
                () => controller.listStudent.isNotEmpty
                    ? ExTextFieldIcon(
                        prefixIcon: Icons.search_rounded,
                        hint: 'text_search'.tr,
                        hintSize: 12,
                        size: 12,
                        tfController: controller.searchController,
                        textAlign: TextAlign.center,
                        onChanged: (value) => controller.filter(),
                      )
                    : Container(),
              ),
              8.heightBox,
              Obx(
                () => controller.listStudentFiltered.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                          leading: Obx(() => Checkbox(value: controller.selectedIndex.value == index, onChanged: (value) => {})),
                          title: Text(
                            controller.listStudentFiltered[index].studentName ?? '',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 12,
                            ),
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: controller.selectedIndex.value == index ? colorPrimary : colorBorder),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onTap: () {
                            controller.selectedIndex.value = index;
                          },
                        ),
                        separatorBuilder: (context, item) => 12.heightBox,
                        itemCount: controller.listStudentFiltered.length,
                      ).expand()
                    : EmptyWidget(
                        message: 'text_student_not_found'.tr,
                        textSize: 12,
                      ).scrollVertical().expand(),
              ),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(h: 128, v: 12).hFull(context),
        ),
        bottomNavigationBar: Obx(
          () => ExButtonDefault(
            label: 'button_enter'.tr,
            labelSize: 12,
            isEnable: controller.listStudentFiltered.isNotEmpty,
            onPressed: () => controller.listStudentFiltered.isEmpty ? null : controller.selectCurrentActiveStudent(),
          ).wFull(context).pOnly(right: 128, left: 128, top: 8, bottom: 12),
        ),
      );
}
