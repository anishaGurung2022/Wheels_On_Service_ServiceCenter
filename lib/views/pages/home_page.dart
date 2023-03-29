import 'dart:async';
import 'package:flutter/material.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/pages/homepageTabs/bookings.dart';
import 'package:service_center/views/pages/homepageTabs/profile/profile.dart';
import 'package:service_center/views/pages/homepageTabs/home_page.dart';
import 'package:tabnavigator/tabnavigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final _tabController = StreamController<AppTab>.broadcast();
  final _initTab = AppTab.home;

  Stream<AppTab> get tabStream => _tabController.stream;

  final _map = <AppTab, TabBuilder>{
    AppTab.home: () {
      return Home();
    },
    AppTab.services: () {
      return Bookings();
    },
    // AppTab.bookings: () {
    //   return ProfilePage();
    // },
    AppTab.profile: () {
      return ProfilePage();
    }
  };

  Widget _buildBody() {
    return TabNavigator(
      initialTab: _initTab,
      selectedTabStream: tabStream,
      mappedTabs: _map,
    );
  }

  Widget _buildbottomNavigationBar() {
    return StreamBuilder<AppTab>(
      stream: tabStream,
      initialData: _initTab,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: primaryColor), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_repair_rounded, color: primaryColor),
                label: 'Bookings'),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.calendar_view_day),
            //   label: 'Bookings',
            // ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: primaryColor),
                label: 'Profile'),
          ],
          currentIndex: snapshot.hasData ? snapshot.data!.value : 0,
          onTap: (value) => _tabController.sink.add(AppTab.byValue(value)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildbottomNavigationBar(),
    );
  }

  @override
  void dispose() {
    _tabController.close();
    super.dispose();
  }
}

class AppTab extends TabType {
  const AppTab._(int value) : super(value);

  static const home = AppTab._(0);
  static const services = AppTab._(1);
  static const profile = AppTab._(2);

  static AppTab byValue(int value) {
    switch (value) {
      case 0:
        return home;
      case 1:
        return services;
      case 2:
        return profile;
      default:
        throw Exception('no tab for such value');
    }
  }
}
