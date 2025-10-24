import 'package:events/home/taps/home/widget/event_item.dart';
import 'package:events/home/widget/custom_text_form_field.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/providers/event_list_provider.dart';
import 'package:events/providers/user_provider.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/event.dart';

class FavoriteTap extends StatefulWidget {
  FavoriteTap({super.key});

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;
  List<Event> filterFavouriteEvent = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllFavouriteEvents(userProvider.currentUser!.id);
      // eventListProvider.getAllFavouriteEventsFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    userProvider = Provider.of<UserProvider>(context);
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
              onChange: (value) {
                searchByName(value);
                setState(() {

                });
              },
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
              searchController.text == '' ?
              ListView.separated(
                padding: EdgeInsets.only(top: height * 0.02),
                itemBuilder: (context, index) {
                  return EventItem(
                      event: eventListProvider.favouriteEventList[index]);
                },
                itemCount: eventListProvider.favouriteEventList.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: height * 0.02),
              ) :
              ListView.separated(
                padding: EdgeInsets.only(top: height * 0.02),
                itemBuilder: (context, index) {
                  return EventItem(
                      event: filterFavouriteEvent[index]);
                },
                itemCount: filterFavouriteEvent.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: height * 0.02),
              )
              ,
            ),
          ],
        ),
      ),
    );
  }

  void searchByName(String text) {
    setState(() {
      if (text
          .trim()
          .isEmpty) {
        filterFavouriteEvent.clear();
      } else {
        filterFavouriteEvent = eventListProvider.favouriteEventList
            .where((event) =>
            event.title.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
    });
  }
}
