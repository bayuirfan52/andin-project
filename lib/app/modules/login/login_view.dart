import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to ... Apps',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
