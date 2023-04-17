import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:music_app/src/screens/category_screen.dart';
import 'package:music_app/src/screens/dashboard_screen.dart';
import 'package:music_app/src/screens/download_screen.dart';

import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  static bool isconnected = false;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription ntwk;

  void connectionCheck()async {
    // Logic to check network connectivity goes here
    bool temp = HomeScreen.isconnected;
    ntwk = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{ 
      HomeScreen.isconnected = await InternetConnectionChecker().hasConnection;
      if(HomeScreen.isconnected==true){
      _controller.jumpToTab(0);
      setState(() {});
    }
    else {
      _controller.jumpToTab(2);
      setState(() {});
    }
    });}
  
  temp(){
    
  }

  @override
  void initState() {
    // TODO: implement initState
    connectionCheck();
    super.initState();
  }
  @override
  void dispose() {
    
    super.dispose();
  }
  
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      // appBar: appBar(context),
      body: PersistentTabView(
        context,
        controller: _controller,
        
        screens: [
          DashboardScreen(),
          CategoryScreen(),
           ChatPage(),
        ],
        items: _navBarsItems(),
        backgroundColor: AppColors.blackColor,
        navBarStyle: NavBarStyle.style3,
        
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: ("Home"),
        activeColorPrimary: AppColors.whiteColor,
        inactiveColorPrimary: Colors.grey[700],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.category_rounded),
        title: ("Category"),
        activeColorPrimary: AppColors.whiteColor,
        inactiveColorPrimary: Colors.grey[700],
      ),
      PersistentBottomNavBarItem(

        icon: const Icon(Icons.download_rounded),
        title: ("Downloads"),
        activeColorPrimary: AppColors.whiteColor,
        inactiveColorPrimary: Colors.grey[700],
      ),
    ];
  }
}
