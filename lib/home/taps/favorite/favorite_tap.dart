import 'package:events/home/taps/home/widget/event_item.dart';
import 'package:events/home/widget/custom_text_form_field.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/providers/event_list_provider.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTap extends StatefulWidget {
  FavoriteTap({super.key});

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllFavouriteEvents();
      // eventListProvider.getAllFavouriteEventsFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
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
              child: eventListProvider.favouriteEventList.isEmpty ?
              Center(
                child: Text(
                  AppLocalizations.of(context)!.no_favourite_event_found,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge,),
              ) :
              ListView.separated(
                padding: EdgeInsets.only(top: height * 0.02),
                itemBuilder: (context, index) {
                  return EventItem(
                      event: eventListProvider.favouriteEventList[index]);
                },
                itemCount: eventListProvider.favouriteEventList.length,
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
