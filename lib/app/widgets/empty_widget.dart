import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.message = 'Data tidak ditemukan',
    this.textSize = 24,
    this.imageSize = 152,
  });

  final String message;
  final double textSize;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Image.asset(
          'assets/images/ic_empty.jpg',
          height: imageSize,
        ).centered(),
        SizedBox(height: 4),
        Text(
          message,
          style: GoogleFonts.aBeeZee(
            fontSize: textSize,
            fontWeight: FontWeight.normal,
          ),
        ).centered(),
      ],
    );
  }
}
