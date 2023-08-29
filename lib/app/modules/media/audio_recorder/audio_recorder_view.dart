import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'audio_recorder_controller.dart';

class AudioRecorderView extends GetView<AudioRecorderController> {
  const AudioRecorderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.isPlayerMode.isTrue ? 'Audio' : 'text_add_audio'.tr)),
        centerTitle: true,
      ),
      body: VStack(
        [
          Obx(
            () => Text(
              controller.timeCount.value,
              style: GoogleFonts.aBeeZee(
                fontSize: 64,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ).centered(),
          16.heightBox,
          Obx(
            () => Visibility(
              visible: controller.status.value == Status.PLAYING || controller.status.value == Status.PAUSED,
              child: Slider(
                value: controller.currentDuration.value / controller.maxDuration.value,
                onChanged: (val) => controller.seekTo(val),
              ).centered(),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.recordedFile.isNotEmpty,
              child: Text(
                controller.recordedFile.value.split('/').last,
                style: GoogleFonts.aBeeZee(fontSize: 14),
                textAlign: TextAlign.center,
              ).centered(),
            ),
          )
        ],
      ).p24().centered(),
      bottomNavigationBar:
          Obx(() => ((controller.status.value == Status.IDLE && controller.recordedFile.isEmpty) || controller.status.value == Status.RECORDING) ? buildButtonRecording() : buildButtonPlaying()),
    );
  }

  Widget buildButtonPlaying() => HStack(
        [
          if (controller.isPlayerMode.isFalse)
            ClipOval(
              child: Material(
                shape: CircleBorder(side: BorderSide(color: colorPrimary)),
                shadowColor: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.red.shade500, // Splash color
                  onTap: () => onRemovePressed(),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.close,
                      color: colorPrimary,
                    ),
                  ),
                ),
              ),
            ),
          8.widthBox,
          HStack([
            if (controller.status.value == Status.IDLE || controller.status.value == Status.PAUSED)
              ClipOval(
                child: Material(
                  color: colorPrimary, // Button color
                  child: InkWell(
                    splashColor: Colors.red.shade500, // Splash color
                    onTap: () => controller.play(),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            else
              ClipOval(
                child: Material(
                  shape: CircleBorder(side: BorderSide(color: colorPrimary)),
                  shadowColor: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.red.shade500, // Splash color
                    onTap: () => controller.pause(),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.pause,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            if (controller.status.value == Status.PLAYING || controller.status.value == Status.PAUSED)
              ClipOval(
                child: Material(
                  color: colorPrimary, // Button color
                  child: InkWell(
                    splashColor: Colors.red.shade500, // Splash color
                    onTap: () => controller.stop(),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.stop,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ).pOnly(left: 8)
          ]),
          8.widthBox,
          if (controller.isPlayerMode.isFalse)
            ClipOval(
              child: Material(
                color: colorPrimary, // Button color
                child: InkWell(
                  splashColor: Colors.red.shade500, // Splash color
                  onTap: () {
                    Get.back<dynamic>(result: controller.recordedFile.value);
                  },
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
        alignment: MainAxisAlignment.spaceEvenly,
      ).p24();

  Widget buildButtonRecording() => HStack(
        [
          if (controller.status.value == Status.RECORDING)
            TextButton(
              onPressed: () => controller.stopRecord(),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                backgroundColor: Colors.red.shade500,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red.shade600),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: HStack([
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade600,
                  ),
                  child: Icon(
                    Icons.stop,
                    color: Colors.white,
                  ).p4(),
                ),
                8.widthBox,
                Text(
                  'button_stop'.tr,
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
            )
          else
            TextButton(
              onPressed: () => controller.startRecord(),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              ),
              child: HStack([
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade600,
                  ),
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                  ).p4(),
                ),
                8.widthBox,
                Text(
                  'button_record'.tr,
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
            )
        ],
        alignment: MainAxisAlignment.center,
      ).p24();

  void onRemovePressed() {
    Get.defaultDialog<dynamic>(
      title: 'text_attention'.tr,
      titleStyle: GoogleFonts.aBeeZee(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      middleText: 'text_alert_remove_audio'.tr,
      middleTextStyle: GoogleFonts.aBeeZee(
        fontSize: 16,
      ),
      cancel: TextButton(
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: colorPrimary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: () {
          Get.back<dynamic>();
        },
        child: Text(
          'button_cancel'.tr,
          style: GoogleFonts.aBeeZee(
            fontSize: 14,
            color: colorPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () => controller.removeFile(),
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorPrimary, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          'button_sure'.tr,
          style: GoogleFonts.aBeeZee(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      buttonColor: colorPrimary,
    );
  }
}
