import 'package:events/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  final String iconName;
  final String eventDateOrTime;
  final String chooseDateOrTime;
  final VoidCallback onChooseEventDateOrTime;

  const DateOrTimeWidget({
    super.key,
    required this.iconName,
    required this.eventDateOrTime,
    required this.onChooseEventDateOrTime,
    required this.chooseDateOrTime,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconName, color: Theme.of(context).cardColor),
        SizedBox(width: width * 0.04),
        Text(eventDateOrTime, style: Theme.of(context).textTheme.titleSmall),
        Spacer(),
        TextButton(
          onPressed: onChooseEventDateOrTime,
          child: Text(chooseDateOrTime, style: AppStyle.medium16Primary),
        ),
      ],
    );
  }
}
