import 'package:flutter/material.dart';
import 'package:service_center/utils/constants.dart';
//import 'package:get/get.dart';

class Bookings extends StatelessWidget {
  //final authentication = Get.find<Authentication>();
  Bookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bookings"),
          backgroundColor: primaryColor,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 60),
              // child: InkWell(
              //   onTap: () => Get.to(() => CartPage()),
              //   child: Badge(
              //     badgeContent: Obx(() => SizedBox(
              //         child: Text(cartController.cart.length.toString()))),
              //     child: const Icon(Icons.shopping_cart),
              //   ),
              // ),
            ),
          ],
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
