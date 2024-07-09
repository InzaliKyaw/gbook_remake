import 'package:flutter/material.dart';
import 'package:gbook_remake/pages/home_page.dart';
import 'package:gbook_remake/pages/library_page.dart';
import 'package:gbook_remake/pages/shop_page.dart';
import 'package:gbook_remake/pages/wishlist_page.dart';
import 'package:gbook_remake/utils/colors.dart';
import 'package:gbook_remake/utils/dimes.dart';
import 'package:gbook_remake/utils/images.dart';
import 'package:gbook_remake/utils/strings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> screenWidgets = [const HomePage(), const LibraryPage(), const WishListPage(), const ShopPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kPrimaryColor,
        selectedFontSize: kTextSmall,
        unselectedFontSize: kTextSmall,
        unselectedItemColor: kBottonNavigationUnSelectedColor,
        showUnselectedLabels: true,
        backgroundColor: kBackgroundColor,
        type: BottomNavigationBarType.fixed,
        items: _getBottomNavigationItems(),
        onTap: (selectedIndex) {
          setState(() {
            currentIndex = selectedIndex;
          });
        },
      ),
      body: screenWidgets[currentIndex],
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems(){
    return [
      BottomNavigationBarItem(icon:
      Image.asset(
        kHomeIcon,
        width: kMarginXLarge,
        height: kMarginXLarge,
      ),
      activeIcon: Image.asset(
        kHomeIcon,
        width: kMarginXLarge,
        height: kMarginXLarge,
        color: kPrimaryColor,
      ),
      label: kHome
      ),
      BottomNavigationBarItem(icon:
      Image.asset(
        kLibraryIcon,
        width: kMarginXLarge,
        height: kMarginXLarge,
      ),
          activeIcon: Image.asset(
            kLibraryIcon,
            width: kMarginXLarge,
            height: kMarginXLarge,
            color: kPrimaryColor,
          ),
          label: kLibrary
      ),
      BottomNavigationBarItem(icon:
      Image.asset(
        kWishListIcon,
        width: kMarginXLarge,
        height: kMarginXLarge,
      ),
          activeIcon: Image.asset(
            kWishListIcon,
            width: kMarginXLarge,
            height: kMarginXLarge,
            color: kPrimaryColor,
          ),
          label: kWishlist
      ),
      BottomNavigationBarItem(icon:
      Image.asset(
        kShopIcon,
        width: kMarginXLarge,
        height: kMarginXLarge,
      ),
          activeIcon: Image.asset(
            kShopIcon,
            width: kMarginXLarge,
            height: kMarginXLarge,
            color: kPrimaryColor,
          ),
          label: kShop
      ),
    ];
  }
}
