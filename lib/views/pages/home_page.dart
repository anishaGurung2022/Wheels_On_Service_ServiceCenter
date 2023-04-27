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
      return BookingPage();
    },
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
          backgroundColor: primaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_repair_rounded, color: Colors.white),
                label: 'Bookings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.white),
                label: 'Profile',
                backgroundColor: primaryColor),
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
