import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(PreferenceHelper.getCurrentAppName()),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => controller.goToSelectStudent(),
              child: Text(
                'button_select_student'.tr,
                textScaleFactor: 1.5,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            )
          ],
        ),
        body: HStack(
          [
            Card(
              elevation: 8,
              child: ZStack([
                Image.asset(
                  'assets/images/img_pecs_1_2.png',
                  width: 480,
                  height: 480,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'PECS 1 & 2',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                )
              ]).onInkTap(() => controller.goToListQuestion(1)),
            ),
            48.widthBox,
            Card(
              elevation: 8,
              child: ZStack([
                Image.asset(
                  'assets/images/img_pecs_3a_3b_1.png',
                  width: 480,
                  height: 480,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'PECS 3A & 3B 1',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                )
              ]).onInkTap(() => controller.goToListQuestion(2)),
            ),
          ],
          alignment: MainAxisAlignment.center,
        ).centered().p24(),
        bottomNavigationBar: Obx(
          () => Text(
            'text_current_active_student'.trParams({'name': controller.currentStudent.value.studentName ?? ''}),
            style: GoogleFonts.aBeeZee(fontSize: 24),
            textAlign: TextAlign.center,
          ).p24(),
        ),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            PreferenceHelper.getCurrentAppName(),
            style: GoogleFonts.aBeeZee(fontSize: 16),
          ),
          centerTitle: true,
          actions: [
            MaterialButton(
              onPressed: () => controller.goToSelectStudent(),
              child: Text(
                'button_select_student'.tr,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            )
          ],
        ),
        body: HStack(
          [
            Card(
              elevation: 8,
              child: ZStack([
                Image.asset(
                  'assets/images/img_pecs_1_2.png',
                  width: 164,
                  height: 164,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'PECS 1 & 2',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                )
              ]).onInkTap(() => controller.goToListQuestion(1)),
            ),
            48.widthBox,
            Card(
              elevation: 8,
              child: ZStack([
                Image.asset(
                  'assets/images/img_pecs_3a_3b_1.png',
                  width: 164,
                  height: 164,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'PECS 3A & 3B 1',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                )
              ]).onInkTap(() => controller.goToListQuestion(2)),
            ),
          ],
          alignment: MainAxisAlignment.center,
        ).centered().p24(),
        bottomNavigationBar: Obx(
          () => Text(
            'text_current_active_student'.trParams({'name': controller.currentStudent.value.studentName ?? ''}),
            style: GoogleFonts.aBeeZee(fontSize: 16),
            textAlign: TextAlign.center,
          ).pSymmetric(v: 8),
        ),
      );
}
