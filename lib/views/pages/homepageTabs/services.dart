import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/form/add_service_form.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/my_button.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
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
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: MyButton(
                  buttonName: 'Add Service',
                  onTap: () => Get.to(const AddEditServiceForm()),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
