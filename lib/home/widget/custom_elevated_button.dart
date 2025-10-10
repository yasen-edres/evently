import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool hasIcon;
  final Widget? childIconWidget;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.backgroundColor = AppColor.primaryLight,
    this.borderColor = AppColor.transparentColor,
    this.textStyle = AppStyle.medium20White,
    this.hasIcon = false,
    this.childIconWidget,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(width: 2, color: borderColor!),
        ),
      ),
      child: hasIcon ? childIconWidget : Text(text ?? "", style: textStyle),
    );
  }
}
