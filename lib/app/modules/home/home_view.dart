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
            ),
          ],
        ),
        body: HStack(
          [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ZStack([
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/img_pecs_1_2.png',
                    width: 480,
                    height: 480,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Level 1',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                ),
              ]).onInkTap(() => controller.goToListQuestion(1)),
            ),
            48.widthBox,
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ZStack([
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/img_pecs_3a_3b_1.png',
                    width: 480,
                    height: 480,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Level 2',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                ),
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
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.5,
              image: AssetImage('assets/images/img_background.jpg'),
            ),
          ),
          child: HStack(
            [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ZStack([
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/img_pecs_1_2.png',
                      width: 164,
                      height: 164,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Level 1',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ]).onInkTap(() => controller.goToListQuestion(1)),
              ),
              48.widthBox,
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ZStack([
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/img_pecs_3a_3b_1.png',
                      width: 164,
                      height: 164,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Level 2',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ]).onInkTap(() => controller.goToListQuestion(2)),
              ),
            ],
            alignment: MainAxisAlignment.center,
          ).centered().p24(),
        ),
        bottomNavigationBar: Obx(
          () => Text(
            'text_current_active_student'.trParams({'name': controller.currentStudent.value.studentName ?? ''}),
            style: GoogleFonts.aBeeZee(fontSize: 16),
            textAlign: TextAlign.center,
          ).pSymmetric(v: 8),
        ),
      );
}
