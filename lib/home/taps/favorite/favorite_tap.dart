import 'package:events/home/widget/custom_text_form_field.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';

class FavoriteTap extends StatelessWidget {
  FavoriteTap({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          children: [
            CustomTextFormField(
              controller: searchController,
              borderSideColor: AppColor.primaryLight,
              hintText: AppLocalizations.of(context)!.search_event,
              hintTextStyle: AppStyle.bold14primary,
              prefixIcon: Image.asset(AppAsset.iconSearch),
            ),
            SizedBox(height: height * 0.005),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: height * 0.02),
                itemBuilder: (context, index) {
                  return Container();
                },
                itemCount: 20,
                separatorBuilder: (context, index) =>
                    SizedBox(height: height * 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
