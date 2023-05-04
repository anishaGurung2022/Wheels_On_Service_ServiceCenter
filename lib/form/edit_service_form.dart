import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_center/controller/category_controller.dart';
import 'package:service_center/controller/service_controller.dart';
import 'package:service_center/controller/serviceCenter_controller.dart';
import 'package:service_center/model/service_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import 'package:service_center/views/components/my_button.dart';
import 'package:service_center/views/components/my_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditServiceForm extends StatefulWidget {
  final Services services;
  const EditServiceForm({super.key, required this.services});

  @override
  State<EditServiceForm> createState() => _AddEditServiceFormState();
}

class _AddEditServiceFormState extends State<EditServiceForm> {
  final ImagePicker _picker = ImagePicker();
  AuthService authService = AuthService();
  PickedFile? pickedFile;
  List<String> values = ['0', '1'];
  int selectedIndex = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ServiceController serviceController = Get.put(ServiceController());
  final ServiceCenterController serviceCenterController =
      Get.put(ServiceCenterController());
  final CategoryController categoryController = Get.find<CategoryController>();
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _idController.text = widget.services.id;
    _nameController.text = widget.services.name;
    _descriptionController.text = widget.services.description;
    priceController.text = widget.services.price.toString();
  }

  _AddEditServiceFormState();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: backgroundColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Edit Service",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: backgroundColor),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20, bottom: 10, right: 20, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                            width: 365,
                            child: MyField(
                              labelText: "Service Name",
                              controller: _nameController,
                              hintText: _nameController.text,
                              prefixIcon: const Icon(Icons.car_repair_sharp),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 365,
                          child: MyField(
                            labelText: "Service Description",
                            controller: _descriptionController,
                            hintText: _descriptionController.text,
                            prefixIcon: const Icon(Icons.description),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 365,
                          child: MyField(
                            labelText: "Price",
                            controller: priceController,
                            hintText: priceController.text,
                            prefixIcon: const Icon(Icons.price_change),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        // //to make container clickable use INKWELL
                        InkWell(
                            //port where image selected
                            onTap: () async {
                              pickedFile = await _picker.getImage(
                                  source: ImageSource.gallery);
                              setState(() {});
                              if (pickedFile != null) {
                                //Get.back();
                              }
                            },
                            child: (pickedFile == null)
                                ? Container(
                                    width: 350,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.add_a_photo),
                                  )
                                : Container(
                                    width: 350,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      //image from file
                                      image: DecorationImage(
                                          image: FileImage(
                                            File(pickedFile!.path),
                                          ),
                                          fit: BoxFit.cover),
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.add_a_photo),
                                  )),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 320,
                          height: 70,
                          child: MyButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  var data = {
                                    "id": _idController.text,
                                    "name": _nameController.text,
                                    "description": _descriptionController.text,
                                    "price": priceController.text,
                                  };
                                  serviceController.updateService(
                                      data, pickedFile);
                                }
                              },
                              buttonName: 'Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
