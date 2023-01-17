import 'package:farmersapp/Screens/account_screen.dart';
import 'package:farmersapp/Screens/buyer_screens/cartscreen.dart';
import 'package:farmersapp/Screens/buyer_screens/homescreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// final mobileBackgroundColor = Theme.of(context).primaryColor;

const primaryColor = Colors.grey;

const secondaryColor = Colors.white;

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // void getUsername() async {
  //   final snap = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     username = (snap.data() as Map<String,dynamic>)['username'];
  //   });
  // }
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
   final  mobileBackgroundColor=Theme.of(context).primaryColor;
    return Scaffold(
      body: PageView(
        
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [BuyerHomeScreen(), CartScreen(), AccountScreen()],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? secondaryColor : primaryColor
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: _page == 1 ? secondaryColor : primaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 2 ? secondaryColor : primaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.favorite,
          //     color: _page == 3 ? primaryColor : secondaryColor,
          //   ),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.person,
          //     color: _page == 3 ? primaryColor : secondaryColor,
          //   ),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
