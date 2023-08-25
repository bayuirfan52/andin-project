import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'image_preview_controller.dart';

class ImagePreviewView extends GetView<ImagePreviewController> {
  const ImagePreviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        leading: Icon(Icons.arrow_back_rounded, color: Colors.white).onInkTap(() => Get.back<dynamic>()),
      ),
      body: Obx(
        () => Center(
          child: controller.url.value.contains('http')
              ? FadeInImage.assetNetwork(
                  image: controller.url.value,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/gif_loading.gif',
                )
              : Image.file(
                  File(controller.url.value),
                  fit: BoxFit.cover,
                ),
        ),
      ).backgroundColor(Colors.black),
    );
  }
}
