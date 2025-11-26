import 'package:events/auth/login/login_navigator.dart';
import 'package:events/auth/login/login_view_model.dart';
import 'package:events/home/widget/custom_elevated_button.dart';
import 'package:events/home/widget/custom_text_form_field.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_routes.dart';
import 'package:events/utils/app_styles.dart';
import 'package:events/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {

  LoginViewModel viewModel = LoginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppAsset.logo),
                  SizedBox(height: height * 0.02),
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(
                          hintText: AppLocalizations.of(context)!.email,
                          prefixIcon: Image.asset(AppAsset.iconEmail),
                          keyboardType: TextInputType.emailAddress,
                          controller: viewModel.emailController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return "pleas enter email"; //todo: invalid
                            }
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(text);
                            if (!emailValid) {
                              return "pleas enter valid email";
                            }
                            return null; //todo: validate valid
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        CustomTextFormField(
                          hintText: AppLocalizations.of(context)!.password,
                          prefixIcon: Image.asset(AppAsset.iconPassword),
                          obscureText: true,
                          suffixIcon: Image.asset(AppAsset.iconShowPassword),
                          controller: viewModel.passwordController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return "pleas enter password"; //todo: invalid
                            }
                            if (text.length < 6) {
                              return "password should be at least 6 chars.";
                            }
                            return null; //todo: validate valid
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              //todo: navigate to forget password screen.
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forget_password,
                              style: AppStyle.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.primaryLight,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        CustomElevatedButton(
                          onPressed: viewModel.login,
                          text: AppLocalizations.of(context)!.login,
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dont_have_account,
                              style: AppStyle.bold16Blak,
                            ),
                            TextButton(
                              onPressed: () {
                                //todo: navigate to register screen.
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoute.registerRouteName);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.create_account,
                                style: AppStyle.bold16Primary.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.primaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                indent: width * 0.04,
                                endIndent: width * 0.04,
                                color: AppColor.primaryLight,
                                thickness: 2,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.or,
                              style: AppStyle.medium16Primary,
                            ),
                            Expanded(
                              child: Divider(
                                indent: width * 0.04,
                                endIndent: width * 0.04,
                                color: AppColor.primaryLight,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        CustomElevatedButton(
                          onPressed: () {
                            viewModel.loginWithGoogle();
                          },
                          hasIcon: true,
                          backgroundColor: AppColor.transparentColor,
                          borderColor: AppColor.primaryLight,
                          childIconWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAsset.iconGoogle),
                              SizedBox(width: width * 0.02),
                              Text(
                                AppLocalizations.of(context)!.login_with_google,
                                style: AppStyle.medium20Primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showMyLoading({required String message}) {
    // TODO: implement showMyLoading
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void navigator(String route) {
    // TODO: implement navigator
    Navigator.of(context).pushReplacementNamed(
      route,
    );
  }

  @override
  void showMyMessage(
      {required String message, String? title, String? posActionName, Function? posAction, String? negActionName, Function? negAction}) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(context: context,
        message: message,
        title: title,
        posAction: posAction,
        posActionName: posActionName,
        negActionName: negActionName,
        negAction: negAction);
  }


}
