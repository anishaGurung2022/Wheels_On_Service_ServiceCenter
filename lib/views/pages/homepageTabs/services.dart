import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/model/service_model.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/my_button.dart';
import 'package:service_center/views/pages/home_page.dart';

class ServicesPage extends StatelessWidget {
  final Services service;
  const ServicesPage({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(service.name),
          backgroundColor: primaryColor,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 60),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Image.network("$baseUrl/${service.image}", height: 250),
                  const SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.5),
                  //         spreadRadius: 5,
                  //         blurRadius: 7,
                  //         offset: const Offset(0, 3), // changes position of shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child:
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text(service.name,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))),
                            Align(
                              alignment: Alignment.center,
                              child: Text("Rs ${service.price}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 0, right: 20, top: 10),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 400,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(service.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(
                                            255, 113, 106, 106))),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    height: 60,
                                    child: MyButton(
                                      onTap: () {
                                        //Get.to(const AddEditServiceForm());
                                      },
                                      buttonName: 'Edit',
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  //),
                ],
              ),
            ],
          ),
        ));
  }
}
