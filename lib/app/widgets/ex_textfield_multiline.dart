import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_text_field_multiline
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   <img width="348" alt="image" src="https://user-images.githubusercontent.com/36602270/169626780-fc30e64c-6f53-46b7-a1d3-d131692fedaf.png">

class ExTextFieldMultiline extends StatelessWidget {
  const ExTextFieldMultiline({
    super.key,
    this.borderColor = const Color(0xFFe4e8eb),
    this.hint,
    this.tfController,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.enabled,
    this.fillColor = Colors.transparent,
    this.textInputAction,
    this.maxLine = 3,
  });
  final Color? borderColor;
  final String? hint;
  final TextEditingController? tfController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return VxTextField(
      borderType: VxTextFieldBorderType.roundLine,
      borderRadius: 4,
      borderColor: borderColor,
      maxLine: maxLine,
      keyboardType: TextInputType.multiline,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      hint: hint,
      enabled: enabled ?? true,
      contentPaddingLeft: 8,
      controller: tfController,
      fillColor: fillColor,
    );
  }
}
