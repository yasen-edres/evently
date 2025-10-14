import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: AppColor.primaryLight),
              SizedBox(width: 20),
              Text(message, style: AppStyle.medium16Black),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget>? actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction != null){
            //   posAction.call();
            // }
            posAction?.call();
          },
          child: Text(posActionName, style: AppStyle.medium20Primary),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(negAction != null){
            //   negAction.call();
            // }
            negAction?.call();
          },
          child: Text(negActionName, style: AppStyle.medium20Primary),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message, style: AppStyle.medium16Black),
        title: Text(title ?? '', style: AppStyle.medium16Black),
        actions: actions,
      ),
    );
  }
}
