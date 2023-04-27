import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/model/service_model.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/views/pages/homepageTabs/services.dart';

class ServiceComponent extends StatelessWidget {
  final Services service;
  const ServiceComponent({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.width / 2,
        width: Get.width / 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Get.to(ServicesPage(service: service)),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(child: Image.network("$baseUrl/${service.image}")),
                    Text(
                      service.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
