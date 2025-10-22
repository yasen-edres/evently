import 'package:events/home/widget/custom_elevated_button.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool languageStatus = false;
  bool themeStatus = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAsset.onboardingTitle, width: width * 0.4),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAsset.onboarding1),
              SizedBox(height: height * 0.02),
              Text(
                AppLocalizations.of(context)!.personalize_your_experience,
                style: AppStyle.bold20Primary,
              ),
              SizedBox(height: height * 0.02),
              Text(
                AppLocalizations.of(context)!.onboarding_des,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: AppStyle.medium20Primary,
                  ),
                  FlutterSwitch(
                    value: languageStatus,
                    activeColor: AppColor.transparentColor,
                    height: height * 0.04,
                    width: width * 0.18,
                    activeIcon: Image.asset(AppAsset.egyptFlag),
                    activeToggleColor: AppColor.primaryLight,
                    inactiveColor: AppColor.transparentColor,
                    inactiveToggleColor: AppColor.primaryLight,
                    inactiveTextFontWeight: FontWeight.bold,
                    activeTextFontWeight: FontWeight.bold,

                    inactiveSwitchBorder: BoxBorder.all(
                      color: AppColor.primaryLight,
                      width: 2,
                    ),
                    activeSwitchBorder: BoxBorder.all(
                      color: AppColor.primaryLight,
                      width: 2,
                    ),
                    inactiveIcon: Image.asset(AppAsset.usaFlag),
                    onToggle: (status) {
                      languageStatus = status;
                      if (languageProvider.appLanguage == 'ar') {
                        languageProvider.changeLanguage('en');
                      } else {
                        languageProvider.changeLanguage('ar');
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: AppStyle.medium20Primary,
                  ),
                  FlutterSwitch(
                    value: themeStatus,
                    activeColor: AppColor.transparentColor,
                    height: height * 0.04,
                    width: width * 0.18,
                    activeIcon: Image.asset(AppAsset.moonIcon),
                    activeToggleColor: AppColor.primaryLight,
                    inactiveColor: AppColor.transparentColor,
                    inactiveToggleColor: AppColor.primaryLight,
                    inactiveTextFontWeight: FontWeight.bold,
                    activeTextFontWeight: FontWeight.bold,

                    inactiveSwitchBorder: BoxBorder.all(
                      color: AppColor.primaryLight,
                      width: 2,
                    ),
                    activeSwitchBorder: BoxBorder.all(
                      color: AppColor.primaryLight,
                      width: 2,
                    ),
                    inactiveIcon: Image.asset(AppAsset.sunIcon),
                    onToggle: (status) {
                      themeStatus = status;
                      if (themeProvider.appTheme == ThemeMode.light) {
                        themeProvider.changeTheme(ThemeMode.dark);
                      } else {
                        themeProvider.changeTheme(ThemeMode.light);
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                onPressed: () {},
                text: AppLocalizations.of(context)!.lets_start,
                textStyle: AppStyle.medium20White,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
