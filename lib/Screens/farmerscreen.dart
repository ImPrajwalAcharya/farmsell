import 'package:farmersapp/Screens/account_screen.dart';
import 'package:farmersapp/Screens/farmer_screens/dashboard_screen.dart';
import 'package:farmersapp/Screens/farmer_screens/myproduct_screen.dart';
import 'package:farmersapp/Screens/farmer_screens/weather_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final mobileBackgroundColor = Colors.teal;

final primaryColor = Colors.grey;

final secondaryColor = Colors.white;

class FarmerScreen extends StatefulWidget {
  const FarmerScreen({super.key});

  @override
  State<FarmerScreen> createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
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
    return Scaffold(
      body: PageView(
        children: [
          DashboardScreen(),
          MyProductScreen(),
          WeatherScreen(),
          AccountScreen()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.teal,
      
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_outlined,
              color: _page == 0 ? secondaryColor : primaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
              color: _page == 1 ? secondaryColor : primaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sunny,
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 3 ? secondaryColor : primaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
