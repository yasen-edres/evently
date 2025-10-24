import 'package:events/home/taps/home/widget/event_item.dart';
import 'package:events/home/taps/home/widget/event_tab_item.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/providers/app_language_provider.dart';
import 'package:events/providers/app_theme_provider.dart';
import 'package:events/providers/event_list_provider.dart';
import 'package:events/providers/user_provider.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    },); //todo: wait to define eventListProvider in build

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    userProvider = Provider.of<UserProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventsNameList(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyle.regular14White,
                ),
                Text(userProvider.currentUser!.name,
                    style: AppStyle.bold24White),
              ],
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      if (appThemeProvider.appTheme == ThemeMode.light) {
                        appThemeProvider.changeTheme(ThemeMode.dark);
                      } else {
                        appThemeProvider.changeTheme(ThemeMode.light);
                      }
                    },
                    child: Image.asset(AppAsset.iconTheme)
                ),
                InkWell(
                  onTap: () {
                    if (appLanguageProvider.appLanguage == 'en') {
                      appLanguageProvider.changeLanguage('ar');
                    } else {
                      appLanguageProvider.changeLanguage('en');
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.01,
                    ),
                    margin: EdgeInsetsDirectional.only(start: width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.whiteColor,
                    ),
                    child: Text(appLanguageProvider.appLanguage.toUpperCase(),
                        style: AppStyle.bold14primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.12,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.01,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(AppAsset.unSelectedIconMap),
                      SizedBox(width: width * 0.02),
                      Text("Damanhour , Egypt", style: AppStyle.medium14White),
                    ],
                  ),
                  DefaultTabController(
                    length: eventListProvider.eventsNameList.length,
                    child: TabBar(
                      onTap: (index) {
                        eventListProvider.changeSelectedIndex(
                            index, userProvider.currentUser!.id);
                      },
                      isScrollable: true,
                      labelPadding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: AppColor.transparentColor,
                      dividerColor: AppColor.transparentColor,
                      tabs: eventListProvider.eventsNameList
                          .map(
                            (e) => EventTabItem(
                              borderColor: Theme.of(context).focusColor,
                              selectedBgColor: Theme.of(context).focusColor,
                              selectedTextStyle: Theme.of(
                                context,
                              ).textTheme.headlineMedium!,
                              unSelectedTextStyle: AppStyle.medium16White,
                              isSelected:
                              eventListProvider.selectedIndex ==
                                  eventListProvider.eventsNameList.indexOf(e),
                              eventName: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: eventListProvider.filterEventList.isEmpty ?
            Center(
              child: Text(AppLocalizations.of(context)!.no_events_found,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,),
            ) :
            ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              itemBuilder: (context, index) {
                return EventItem(
                  event: eventListProvider.filterEventList[index],
                );
              },
              itemCount: eventListProvider.filterEventList.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: height * 0.02),
            ),
          ),
        ],
      ),
    );
  }

}
