import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.primaryLight,
    focusColor: AppColor.whiteColor,
    dividerColor: AppColor.whiteColor,
    indicatorColor: AppColor.grayColor,
    splashColor: AppColor.grayColor,
    cardColor: AppColor.blackColor,
    scaffoldBackgroundColor: AppColor.whiteBgColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColor.primaryLight),
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyle.bold20Blak,
      headlineMedium: AppStyle.medium16Primary,
      titleMedium: AppStyle.bold16White,
      titleSmall: AppStyle.medium16Black,
      bodyLarge: AppStyle.medium16Gray,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.primaryLight,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.whiteBgColor,
      unselectedItemColor: AppColor.whiteBgColor,
      selectedLabelStyle: AppStyle.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryLight,
      shape: StadiumBorder(
        side: BorderSide(color: AppColor.whiteColor, width: 6),
      ),
      // RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(35),
      //   side: BorderSide(
      //     width: 4,
      //     color: AppColor.whiteColor
      //   )
      // )
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColor.primaryDark,
    focusColor: AppColor.primaryLight,
    dividerColor: AppColor.primaryDark,
    indicatorColor: AppColor.whiteColor,
    splashColor: AppColor.primaryLight,
    cardColor: AppColor.whiteColor,

    scaffoldBackgroundColor: AppColor.primaryDark,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColor.primaryLight),
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyle.bold20White,
      headlineMedium: AppStyle.medium16White,
      titleMedium: AppStyle.bold16PrimaryDark,
      titleSmall: AppStyle.medium16White,
      bodyLarge: AppStyle.medium16White,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.primaryDark,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.grayColor,
      unselectedItemColor: AppColor.grayColor,
      selectedLabelStyle: AppStyle.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryDark,
      shape: StadiumBorder(
        side: BorderSide(color: AppColor.whiteColor, width: 6),
      ),
      // RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(35),
      //     side: BorderSide(
      //         width: 4,
      //         color: AppColor.whiteColor
      //     )
      // )
    ),
  );
}
