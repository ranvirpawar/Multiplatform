import 'package:flutter/material.dart';
import 'package:multiplatorm/constant/colors.dart';

class CButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const CButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: rBlackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        onPressed: onTap,
        child: Text(text, style: TextStyle(color: rWhiteColor)),
      ),
    );
  }
}
