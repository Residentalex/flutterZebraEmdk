import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants/colors.dart';

class TextFieldSection extends StatelessWidget {
  final String label;
  final String hint;
  final dynamic inputType;
  final String? value;
  final TextAlign align;
  final bool readOnly;
  final TextEditingController? controller;
  final FloatingLabelAlignment floatLabelAlign;
  final int maxLines;
  final String? Function(String?)? validator;

  const TextFieldSection({
    Key? key,
    required this.label,
    required this.hint,
    required this.inputType,
    this.value,
    this.readOnly = false,
    this.align = TextAlign.start,
    this.floatLabelAlign = FloatingLabelAlignment.start,
    this.controller,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (controller != null && value != null) {
      controller!.text = value!;
    }
    return TextFormField(
      controller: controller ?? TextEditingController(text: value),
      textAlign: align,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        labelText: label,
        floatingLabelAlignment: floatLabelAlign,
        labelStyle: GoogleFonts.raleway(
            color: const Color(0xFF444444),
            textStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        fillColor: const Color(0xFFFCFCFC),
        filled: true,
        hintText: hint,
        hintStyle: GoogleFonts.nunito(
            textStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ColorSchema.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: validator,
      keyboardType: inputType,
      minLines: maxLines,
      maxLines: maxLines,
      readOnly: readOnly,
    );
  }
}
