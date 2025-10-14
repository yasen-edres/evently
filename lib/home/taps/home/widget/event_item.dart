import 'package:events/providers/event_list_provider.dart';
import 'package:events/providers/user_provider.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../model/event.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key,
    required this.event
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      height: height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: AppColor.primaryLight),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
              event.eventImage
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.005,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${event.eventDateTime.day}',
                      style: AppStyle.bold20Primary),
                  Text(DateFormat('MMM').format(event.eventDateTime),
                      style: AppStyle.bold14primary),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.005,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.whiteColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: AppStyle.bold14Blak,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      eventListProvider.updateIsFavouriteEvent(
                          event, userProvider.currentUser!.id);
                    },
                    child: event.isFavorite == true ?
                    Image.asset(
                      AppAsset.selectedIconFavorite,
                      color: AppColor.primaryLight,
                    ) :
                    Image.asset(AppAsset.unSelectedIconFavorite,
                      color: AppColor.primaryLight,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
