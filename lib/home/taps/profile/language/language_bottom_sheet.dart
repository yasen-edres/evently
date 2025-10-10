import 'package:events/l10n/app_localizations.dart';
import 'package:events/providers/app_language_provider.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              //todo: change language to en .
              languageProvider.changeLanguage("en");
            },
            child: languageProvider.appLanguage == "en"
                ? getSelectedItemWidget(
                    language: AppLocalizations.of(context)!.english,
                  )
                : getUnSelectedItemWidget(
                    language: AppLocalizations.of(context)!.english,
                  ),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              //todo: change language to en .
              languageProvider.changeLanguage("ar");
            },
            child: languageProvider.appLanguage == "ar"
                ? getSelectedItemWidget(
                    language: AppLocalizations.of(context)!.arabic,
                  )
                : getUnSelectedItemWidget(
                    language: AppLocalizations.of(context)!.arabic,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget({required String language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: AppStyle.bold20Primary),
        const Icon(Icons.check, size: 30, color: AppColor.primaryLight),
      ],
    );
  }

  Widget getUnSelectedItemWidget({required String language}) {
    return Text(language, style: AppStyle.bold20Blak);
  }
}
