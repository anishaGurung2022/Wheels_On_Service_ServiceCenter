import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/authentication_controller.dart';
import 'package:service_center/controller/category_controller.dart';
import 'package:service_center/controller/city_controller.dart';
import 'package:service_center/controller/service_controller.dart';
import 'package:service_center/views/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //calling the GetX Controller classes so that data are fetched in start
  Get.put(Authentication()); //fetches token
  Get.put(CitiesController()); // fetches cities
  Get.put(CategoryController());
  //Get.put(ServiceCenterController());
  Get.put(ServiceController());
  //fetches categories
  // Get.put(CartController());
  runApp(GetMaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}
