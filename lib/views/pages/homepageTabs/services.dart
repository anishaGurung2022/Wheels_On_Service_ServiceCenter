import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/service_controller.dart';
import 'package:service_center/form/edit_service_form.dart';
import 'package:service_center/model/service_model.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/my_button.dart';

class ServicesPage extends StatefulWidget {
  final Services service;
  const ServicesPage({Key? key, required this.service}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  bool _switchValue = false;
  ServiceController serviceController = Get.put(ServiceController());

  @override
  void initState() {
    super.initState();
    _switchValue = widget.service.activeStatus == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.service.name),
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
                Image.network("$baseUrl/${widget.service.image}", height: 250),
                const SizedBox(
                  height: 10,
                ),
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
                              child: Text(widget.service.name,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Rs ${widget.service.price}",
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
                              child: Text(widget.service.description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 113, 106, 106))),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Active Status',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: _switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                  // Perform any additional logic or actions here based on the new value of _switchValue
                                },
                              )
                            ],
                          ),
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
                                      Get.to(EditServiceForm(
                                          services: widget.service));
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
        )));
  }
}
