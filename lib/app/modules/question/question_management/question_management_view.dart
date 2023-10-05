import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'question_management_controller.dart';

class QuestionManagementView extends GetView<QuestionManagementController> {
  const QuestionManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('text_question_management'.tr),
          centerTitle: true,
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
                  opacity: AlwaysStoppedAnimation(.75),
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
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.edit,
                      size: 48,
                    ).pOnly(bottom: 12, right: 12),
                  ),
                ),
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
                  opacity: AlwaysStoppedAnimation(.75),
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
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.edit,
                      size: 48,
                    ).pOnly(bottom: 12, right: 12),
                  ),
                ),
              ]).onInkTap(() => controller.goToListQuestion(2)),
            ),
          ],
          alignment: MainAxisAlignment.center,
        ).centered().p24(),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'text_question_management'.tr,
            style: GoogleFonts.aBeeZee(fontSize: 16),
          ),
          centerTitle: true,
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
                  opacity: AlwaysStoppedAnimation(.75),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Level 1',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.edit,
                      size: 24,
                    ).pOnly(bottom: 12, right: 12),
                  ),
                ),
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
                  opacity: AlwaysStoppedAnimation(.75),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Level 2',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(bottom: 12),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.edit,
                      size: 24,
                    ).pOnly(bottom: 12, right: 12),
                  ),
                ),
              ]).onInkTap(() => controller.goToListQuestion(2)),
            ),
          ],
          alignment: MainAxisAlignment.center,
        ).centered().p24(),
      );
}
