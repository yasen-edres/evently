import 'package:events/auth/register/register_navigator.dart';
import 'package:events/auth/register/register_view_model.dart';
import 'package:events/home/widget/custom_elevated_button.dart';
import 'package:events/home/widget/custom_text_form_field.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:events/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController(text: "yassin");
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  RegisterViewModel viewModel = RegisterViewModel();

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
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColor.blackColor),
          backgroundColor: AppColor.transparentColor,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.register,
            style: AppStyle.bold16Blak,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppAsset.logo),
                SizedBox(height: height * 0.02),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.name,
                        prefixIcon: Image.asset(AppAsset.iconName),
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return "pleas enter name"; //todo: invalid
                          }
                          return null; //todo: validate valid
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.email,
                        prefixIcon: Image.asset(AppAsset.iconEmail),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
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
                        controller: passwordController,
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
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.re_password,
                        prefixIcon: Image.asset(AppAsset.iconPassword),
                        obscureText: true,
                        suffixIcon: Image.asset(AppAsset.iconShowPassword),
                        controller: rePasswordController,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return "pleas enter password"; //todo: invalid
                          }
                          if (text != passwordController.text) {
                            return "Re-Password doesn't match password";
                          }
                          return null; //todo: validate valid
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        onPressed: register,
                        text: AppLocalizations.of(context)!.create_account,
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_have_account,
                            style: AppStyle.bold16Blak,
                          ),
                          TextButton(
                            onPressed: () {
                              //todo: navigate to login screen.
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: AppStyle.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(emailController.text, passwordController.text);
    }
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
  void showMyMessage({required String message}) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(context: context, message: message,
        posActionName: 'Ok');
  }
}
