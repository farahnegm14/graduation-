import 'package:flutter/material.dart';
import 'package:graduation_project/commen_component/app_colors/color_extension.dart';


class CustomButtonDetection extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  final double iconSize;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final VoidCallback onTap;

  const CustomButtonDetection({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.iconSize = 60,
    this.fontSize = 25,
    this.fontWeight = FontWeight.bold,
    this.borderRadius = 20,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                TColor.primaryColor1,
                TColor.primaryColor2
              ],
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: iconColor,
                ),
                const SizedBox(height: 10,),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}