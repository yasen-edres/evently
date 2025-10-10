import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: OnBoardingSlider(
        totalPage: 4,
        headerBackgroundColor: AppColor.whiteColor,
        background: [
          Image.asset(AppAsset.onboarding1),
          Image.asset(AppAsset.onboarding2),
          Image.asset(AppAsset.onboarding3),
          Image.asset(AppAsset.onboarding4),
        ],
        speed: 1.8,
        pageBodies: [
          Column(
            children: [
              SizedBox(height: size.height * 0.45),
              Column(
                children: [
                  Text(
                    'Personalize Your Experience',
                    style: TextStyle(
                      color: AppColor.primaryLight,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  Text(
                    'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: size.height * 0.45),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: Column(
                  children: [
                    Text(
                      'Her goal...',
                      style: TextStyle(
                        color: AppColor.primaryLight,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      'Organizing events and managing all logistical details.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: size.height * 0.45),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: Column(
                  children: [
                    Text(
                      'Her goal...',
                      style: TextStyle(
                        color: AppColor.primaryLight,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      'Building relationships and enhancing the entitys image in front of the public and partners',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: size.height * 0.45),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: Column(
                  children: [
                    Text(
                      'Her goal...',
                      style: TextStyle(
                        color: AppColor.primaryLight,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      'Create and manage content to increase online engagement.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        hasSkip: false,
        skipIcon: Icon(Icons.arrow_back),
        finishButtonText: 'Let’s Start',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: AppColor.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width),
          ),
        ),
        centerBackground: true,
        imageVerticalOffset: 20,

        trailing: Text('Login'),
        // trailingFunction: () => Navigator.of(context).pushNamed(AppRoute.loginRouteName),
        controllerColor: AppColor.primaryLight,
        onFinish: () {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) =>  RegisterScreen(),
          //   ),
          // );
        },
      ),
    );
  }
}
