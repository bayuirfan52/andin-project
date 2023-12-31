import 'dart:io';

import 'package:andin_project/app/extensions/string_extensions.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_avatar_view
///   date                  : 21 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///  <img width="200" alt="image" src="https://user-images.githubusercontent.com/36602270/169626607-f16c4fca-dce0-4095-b09c-c5ce915b649e.png">

class ExImageView extends StatelessWidget {
  const ExImageView({
    required this.image,
    super.key,
    this.height,
    this.width,
    this.size,
    this.borderColor,
    this.borderWidth,
    this.radius = 8,
    this.boxFit = BoxFit.cover,
    this.isAllowPreview = false,
    this.errorIcon = Icons.image,
    this.canRemove = false,
  });

  final String image;
  final double? height;
  final double? width;
  final double? size;
  final Color? borderColor;
  final double? borderWidth;
  final double radius;
  final BoxFit boxFit;
  final bool? isAllowPreview;
  final IconData? errorIcon;
  final bool? canRemove;

  @override
  Widget build(BuildContext context) {
    if (isAllowPreview ?? true) {
      return ZStack(
        [
          Container(
            width: size ?? width,
            height: size ?? height,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor ?? Colors.grey[300]!, width: borderWidth ?? 0.5),
            ),
            child: image.isUrl!
                ? Image.network(
                    '$image',
                    width: size ?? width,
                    height: size ?? height,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Image.asset(
                        'assets/images/gif_loading.gif',
                        width: 24,
                        height: 24,
                      ).centered();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.grey[300], child: Icon(errorIcon));
                    },
                  )
                : Image.file(
                    File(image),
                    width: size ?? width,
                    height: size ?? height,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                    errorBuilder: (context, error, stackTrace) {
                      logE('$error - ${stackTrace}');
                      return Container(color: Colors.grey[300], child: Icon(errorIcon));
                    },
                  ),
          ).cornerRadius(radius),
        ],
      ).onTap(() {
        if (isAllowPreview ?? true) {
          Get.toNamed<dynamic>(Routes.IMAGE_PREVIEW, arguments: image);
        }
      });
    } else {
      return ZStack(
        [
          Container(
            width: size ?? width,
            height: size ?? height,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor ?? Colors.grey[300]!, width: borderWidth ?? 0.5),
            ),
            child: image.isUrl!
                ? Image.network(
                    '$image',
                    width: size ?? width,
                    height: size ?? height,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Image.asset(
                        'assets/images/gif_loading.gif',
                        width: 24,
                        height: 24,
                      ).centered();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.grey[300], child: Icon(errorIcon));
                    },
                  )
                : Image.file(
                    File(image),
                    width: size ?? width,
                    height: size ?? height,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                    errorBuilder: (context, error, stackTrace) {
                      logE('$error - ${stackTrace}');
                      return Container(color: Colors.grey[300], child: Icon(errorIcon));
                    },
                  ),
          ).cornerRadius(radius),
        ],
      );
    }
  }
}
