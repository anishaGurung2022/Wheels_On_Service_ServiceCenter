//import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/service_controller.dart';
import 'package:service_center/model/service_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/service_component.dart';

class Home extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  // final CartController cartController = Get.find<CartController>();
  Home({Key? key}) : super(key: key);

  @override
  //Services page(user can see all services)
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
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
              child: const InkWell(
                child: Icon(Icons.notifications),
              ),
            ),
          ],
        ),
        body: Obx(() => Wrap(
              children: serviceController.services.value
                  .map((Services services) =>
                      ServiceComponent(service: services))
                  .toList(),
            )),
      ),
    );
  }
}
