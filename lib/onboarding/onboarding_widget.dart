import 'package:events/l10n/app_localizations.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_routes.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingWidget extends StatefulWidget {
  OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<PageViewModel> tabs = [
      PageViewModel(
        title: '',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.find_events_that_inspire_you,
              style: AppStyle.bold20Primary,
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.onboarding1_des,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        image: Center(child: Image.asset(AppAsset.onboarding1)),
      ),
      PageViewModel(
        title: '',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.effortless_event_planning,
              style: AppStyle.bold20Primary,
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.onboarding2_des,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        image: Center(child: Image.asset(AppAsset.onboarding2)),
      ),
      PageViewModel(
        title: '',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.connect_with_friends_share_moments,
              style: AppStyle.bold20Primary,
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.onboarding3_des,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        image: Center(child: Image.asset(AppAsset.onboarding3)),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAsset.onboardingTitle, width: width * 0.4),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: IntroductionScreen(
        pages: tabs,
        showNextButton: true,
        next: Container(
          width: width * 0.1,
          height: height * 0.05,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(color: AppColor.primaryLight, width: 2),
          ),
          child: Icon(Icons.arrow_forward, color: AppColor.primaryLight),
        ),
        back: Container(
          width: width * 0.1,
          height: height * 0.05,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(color: AppColor.primaryLight, width: 2),
          ),
          child: Icon(Icons.arrow_back, color: AppColor.primaryLight),
        ),
        dotsFlex: 4,
        showBackButton: true,
        done: Container(
          width: width * 0.3,
          height: height * 0.045,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(color: AppColor.primaryLight, width: 2),
          ),
          child: Icon(Icons.arrow_forward, color: AppColor.primaryLight),
        ),
        dotsDecorator: DotsDecorator(
          color: Theme.of(context).cardColor,
          activeColor: AppColor.primaryLight,
        ),
        onDone: () {
          //todo: Navigator to login screen
          Navigator.of(context).pushReplacementNamed(AppRoute.loginRouteName);
        },
      ),
    );
  }
}
