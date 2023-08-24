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
    return Scaffold(
      appBar: AppBar(
        title: Text(PreferenceHelper.getCurrentAppName()),
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
              )
            ]).onInkTap(() => controller.goToListQuestion(1)),
          ),
          48.widthBox,
          Card(
            child: ZStack([
              Image.network(
                'https://www.kamiapp.com/wp-content/uploads/2022/09/Certified-Banner-2-1024x917.jpg',
                width: 480,
                height: 480,
                fit: BoxFit.cover,
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
              )
            ]).onInkTap(() => controller.goToListQuestion(2)),
          ),
        ],
        alignment: MainAxisAlignment.center,
      ).centered().p24(),
    );
  }
}
