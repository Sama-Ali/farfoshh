import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String labelText;
  final TextInputType textInputType;

  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.labelText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isPass,
      keyboardType: textInputType,
      textAlign: TextAlign.right, // Align text to the right for Arabic
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.cairo(
          color: Color(0xFF0D2240).withOpacity(0.7),
          fontSize: 12,
        ),
        border: UnderlineInputBorder(), // Underlined border
      ),
    );
  }
}
