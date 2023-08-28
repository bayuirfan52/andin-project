import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'question_management_controller.dart';

class QuestionManagementView extends GetView<QuestionManagementController> {
  const QuestionManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Management'),
        centerTitle: true,
      ),
      body: HStack(
        [
          Card(
            child: ZStack([
              Image.network(
                'https://www.kamiapp.com/wp-content/uploads/2022/09/Certified-Banner-2-1024x917.jpg',
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
            child: ZStack([
              Image.network(
                'https://rollhappy.co.uk/cdn/shop/collections/roll-happy-rollerskating-level-2_1200x1200.jpg?v=1680537955',
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
  }
}
