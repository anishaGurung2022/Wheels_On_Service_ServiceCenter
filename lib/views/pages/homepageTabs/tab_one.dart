//import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:service_center/utils/constants.dart';

class TabOne extends StatelessWidget {
  // final ProductController productController = Get.put(ProductController());
  // final CartController cartController = Get.find<CartController>();
  const TabOne({Key? key}) : super(key: key);

  @override
  //Services page(user can see all services)
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
        ],
      ),
      // body: Obx(() => Wrap(
      //       children: productController.products.value
      //           .map((Product product) => ProductComponent(product: product))
      //           .toList(),
      //     )),
    );
  }
}
