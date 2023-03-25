//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/authentication_controller.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/my_button.dart';

class ProfilePage extends StatelessWidget {
  final authentication = Get.find<Authentication>();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                width: 200,
                height: 200,
                child: Image(
                  image: AssetImage('assets/images/profile_pic.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    await authentication.logout();
  }
}
