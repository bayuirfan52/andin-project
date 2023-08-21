import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack([
        Text(
          'Welcome to ??? Apps',
          style: GoogleFonts.aBeeZee(
            fontSize: 48,
            fontWeight: FontWeight.w700,
          ),
        ),
        48.heightBox,

      ]).p24().centered(),
    );
  }
}
