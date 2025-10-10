import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  final bool isSelected;
  final String eventName;
  final Color selectedBgColor;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final Color borderColor;

  const EventTabItem({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.selectedBgColor,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.006,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.01,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(width: 2, color: borderColor),
        color: isSelected ? selectedBgColor : AppColor.transparentColor,
      ),
      child: Row(
        children: [
          Text(
            eventName,
            style: isSelected ? selectedTextStyle : unSelectedTextStyle,
          ),
        ],
      ),
    );
  }
}
