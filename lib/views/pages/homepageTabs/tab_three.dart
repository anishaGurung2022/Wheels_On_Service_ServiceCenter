import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class TabThree extends StatelessWidget {
  //final authentication = Get.find<Authentication>();
  TabThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 150, 218, 231),
        body: Column(
          children: [
            // ElevatedButton(
            //     onPressed: () => logout(), child: const Text("Logout")),
          ],
        ),
      ),
    );
  }

  // logout() async {
  //   await authentication.logout();
  // }
}
