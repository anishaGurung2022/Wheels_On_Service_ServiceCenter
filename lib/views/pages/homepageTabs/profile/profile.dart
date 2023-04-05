import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/authentication_controller.dart';
import 'package:service_center/controller/serviceCenter_controller.dart';
import 'package:service_center/model/serviceCenter_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/profile_component.dart';

class ProfilePage extends StatelessWidget {
  final authentication = Get.find<Authentication>();
  final ServiceCenterController serviceCenterController =
      Get.put(ServiceCenterController());
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: primaryColor,
        ),
        body: Obx(() => Wrap(
            children: serviceCenterController.serviceCenterDetails.value
                .map((ServiceCenter serviceCenterDetails) =>
                    ProfileComponent(serviceCenter: serviceCenterDetails))
                .toList())),
      ),
    );
  }

  logout() async {
    await authentication.logout();
  }
}
