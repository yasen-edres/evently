import 'package:events/home/taps/favorite/favorite_tap.dart';
import 'package:events/home/taps/home/home_tap.dart';
import 'package:events/home/taps/map/map_tap.dart';
import 'package:events/home/taps/profile/profile_tap.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:events/utils/appAssets.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [HomeTap(), MapTap(), FavoriteTap(), ProfileTap()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          builtBottomNavItem(
            index: 0,
            unSelectedIconName: AppAsset.unSelectedIconHome,
            selectedIconName: AppAsset.selectedIconHome,
            label: AppLocalizations.of(context)!.home,
          ),
          builtBottomNavItem(
            index: 1,
            unSelectedIconName: AppAsset.unSelectedIconMap,
            selectedIconName: AppAsset.selectedIconMap,
            label: AppLocalizations.of(context)!.map,
          ),
          builtBottomNavItem(
            index: 2,
            unSelectedIconName: AppAsset.unSelectedIconFavorite,
            selectedIconName: AppAsset.selectedIconFavorite,
            label: AppLocalizations.of(context)!.love,
          ),
          builtBottomNavItem(
            index: 3,
            unSelectedIconName: AppAsset.unSelectedIconProfile,
            selectedIconName: AppAsset.selectedIconProfile,
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo: Navigate to add Event.
          Navigator.of(context).pushNamed(AppRoute.addEventRouteName);
        },
        child: Icon(Icons.add, size: 35, color: AppColor.whiteColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabsList[selectedIndex],
    );
  }

  BottomNavigationBarItem builtBottomNavItem({
    required String selectedIconName,
    required String unSelectedIconName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : unSelectedIconName,
        ),
      ),
      label: label,
    );
  }
}
