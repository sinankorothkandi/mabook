import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';

class CustomTextFiel extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool isPassword;
  final bool isreadOnly;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final String? validatorText;
  final int? maxline;
  final TextInputType? keyboardtype;

  const CustomTextFiel({
    super.key,
    required this.titleText,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.suffixIcon,
    this.validatorText,
    this.maxline,
    this.keyboardtype,
    this.isreadOnly = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: GoogleFonts.poppins(fontSize: 20, color: green),
          ),
          const SizedBox(
            height: 3,
          ),
          TextFormField(
            keyboardType: keyboardtype,
            maxLines: maxline,
            readOnly: isreadOnly,
            controller: controller,
            obscureText: isPassword,
           
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 30),              suffixIcon: Icon(suffixIcon),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(color: grey, fontSize: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: green, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: green, width: 3),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $validatorText';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
