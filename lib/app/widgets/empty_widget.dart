import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.message = 'Data tidak ditemukan',
    this.textSize = 24,
  });
  final String message;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Image.asset(
          'assets/images/ic_empty.jpg',
          height: 152,
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
