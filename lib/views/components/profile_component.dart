import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/authentication_controller.dart';
import 'package:service_center/form/edit_profile_form.dart';
import 'package:service_center/model/serviceCenter_model.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/views/components/my_button.dart';

class ProfileComponent extends StatelessWidget {
  final ServiceCenter serviceCenter;
  final authentication = Get.find<Authentication>();
  ProfileComponent({super.key, required this.serviceCenter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 600,
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(10),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey.withOpacity(0.5),
                  //       spreadRadius: 5,
                  //       blurRadius: 7,
                  //       offset:
                  //           const Offset(0, 3), // changes position of shadow
                  //     ),
                  //   ],
                  // ),
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                        child:
                            Image.network("$baseUrl/${serviceCenter.image}")),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: 700,
                      decoration: BoxDecoration(
                        color: const Color(0xffdedede),
                        border: Border.all(
                            width: 1.0,
                            color: const Color.fromARGB(255, 169, 169, 169)),
                      ),
                      child: Center(
                        child: Text(
                          serviceCenter.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 700,
                      decoration: BoxDecoration(
                        color: const Color(0xffdedede),
                        border: Border.all(
                            width: 1.0,
                            color: const Color.fromARGB(255, 169, 169, 169)),
                      ),
                      child: Center(
                        child: Text("Contact Number:  ${serviceCenter.phone}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 700,
                      decoration: BoxDecoration(
                        color: const Color(0xffdedede),
                        border: Border.all(
                            width: 1.0,
                            color: const Color.fromARGB(255, 169, 169, 169)),
                      ),
                      child: Center(
                        child: Text("Email:  ${serviceCenter.email}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 700,
                      decoration: BoxDecoration(
                        color: const Color(0xffdedede),
                        border: Border.all(
                            width: 1.0,
                            color: const Color.fromARGB(255, 169, 169, 169)),
                      ),
                      child: Center(
                        child: Text("Address:  ${serviceCenter.address}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 190,
                      child: MyButton(
                        buttonName: 'Edit Profile',
                        onTap: () => Get.to(
                            EditProfileForm(serviceCenter: serviceCenter)),
                      ),
                    ),
                    SizedBox(
                      width: 190,
                      child: MyButton(
                        buttonName: 'Logout',
                        onTap: () => logout(),
                      ),
                    )
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  logout() async {
    await authentication.logout();
  }
}
