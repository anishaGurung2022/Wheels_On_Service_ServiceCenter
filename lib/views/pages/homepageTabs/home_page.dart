//import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/service_controller.dart';
import 'package:service_center/form/add_service_form.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Bike Services",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              const SizedBox(
                                width: 120,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const AddEditServiceForm());
                                },
                                child: const Text(
                                  " + Add more",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              )
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    getBikeServices(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Car Services",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              const SizedBox(
                                width: 120,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const AddEditServiceForm());
                                },
                                child: const Text(
                                  " + Add more",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      getCarServices(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Obx(() => Wrap(
  //       children: serviceController.services.value
  //           .map((Services services) =>
  //               ServiceComponent(service: services))
  //           .toList(),
  //     )),

  getBikeServices() {
    return Obx((() => Wrap(
          children: serviceController.services.value
              .where(
                  (Services services) => services.category == "Bike Services")
              .map((service) => ServiceComponent(service: service))
              .toList(),
        )));
  }

  getCarServices() {
    return Obx((() => Wrap(
          children: serviceController.services.value
              .where((Services services) => services.category == "Car Services")
              .map((service) => ServiceComponent(service: service))
              .toList(),
        )));
  }
}
