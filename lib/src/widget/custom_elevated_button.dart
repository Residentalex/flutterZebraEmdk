import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonName;
  final Function showToast;

  const CustomElevatedButton(
      {Key? key, required this.buttonName, required this.showToast});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: () => showToast(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          buttonName,
          style: GoogleFonts.raleway(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }
}
