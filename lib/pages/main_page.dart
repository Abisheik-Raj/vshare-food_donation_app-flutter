import "package:flutter/material.dart";
import "package:google_nav_bar/google_nav_bar.dart";
import "package:vshare/pages/account_page.dart";
import "package:vshare/pages/home_page.dart";
import "package:vshare/pages/offer_page.dart";
import "package:vshare/resources/Colors.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pagesList = [HomePage(), OfferPage(), AccountPage()];
  int pages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: GNav(
            color: Colors.white,
            gap: 2,
            backgroundColor: darkGreenColor,
            activeColor: Colors.white,
            tabBackgroundColor: lightGreenColor,
            padding: EdgeInsets.symmetric(horizontal: 20),
            onTabChange: (value) {
              setState(() {
                pages = value;
              });
            },
            tabs: [
              GButton(
                padding: EdgeInsets.all(10),
                icon: Icons.home,
                text: "  Home",
              ),
              GButton(
                padding: EdgeInsets.all(10),
                icon: Icons.local_offer,
                text: " Donate",
              ),
              GButton(
                padding: EdgeInsets.all(10),
                icon: Icons.switch_account_outlined,
                text: " Account",
              ),
            ]),
      ),
      backgroundColor: darkGreenColor,
      body: pagesList[pages],
    );
  }
}
