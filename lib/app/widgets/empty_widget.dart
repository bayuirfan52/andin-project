import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.message = 'Data tidak ditemukan',
  });
  final String message;

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
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ).centered()
      ],
    );
  }
}
