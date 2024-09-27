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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ZStack([
                Image.asset(
                  'assets/images/img_pecs_1_2.png',
                  width: 480,
                  height: 480,
                  fit: BoxFit.contain,
                  opacity: AlwaysStoppedAnimation(.75),
                ),
                /*Positioned.fill(
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
                ),*/
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ZStack([
                Image.asset(
                  'assets/images/img_pecs_3a_3b_1.png',
                  width: 480,
                  height: 480,
                  fit: BoxFit.contain,
                  opacity: AlwaysStoppedAnimation(.75),
                ),
                /*Positioned.fill(
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
                ),*/
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
                      opacity: AlwaysStoppedAnimation(.75),
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
                          style: GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ZStack([
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/img_pecs_3a_3b_1.png',
                      width: 164,
                      height: 164,
                      fit: BoxFit.contain,
                      opacity: AlwaysStoppedAnimation(.75),
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
                          style: GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
        ),
      );
}
