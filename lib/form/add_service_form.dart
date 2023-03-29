import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_center/controller/category_controller.dart';
import 'package:service_center/controller/service_controller.dart';
import 'package:service_center/controller/serviceCenter_controller.dart';
import 'package:service_center/model/category_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/my_button.dart';
import 'package:service_center/views/components/my_field.dart';

class AddEditServiceForm extends StatefulWidget {
  const AddEditServiceForm({super.key});

  @override
  State<AddEditServiceForm> createState() => _AddEditServiceFormState();
}

class _AddEditServiceFormState extends State<AddEditServiceForm> {
  final ImagePicker _picker = ImagePicker();
  PickedFile? pickedFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ServiceController serviceController = Get.put(ServiceController());
  final ServiceCenterController serviceCenterController =
      Get.put(ServiceCenterController());
  final CategoryController categoryController = Get.find<CategoryController>();
  String? selectedValue;
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
            "Add Service",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: backgroundColor),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
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
                        prefixIcon: const Icon(Icons.car_repair_sharp),
                      )),
                  SizedBox(
                    width: 365,
                    child: MyField(
                      labelText: "Service Description",
                      controller: _descriptionController,
                      prefixIcon: const Icon(Icons.description),
                    ),
                  ),
                  SizedBox(
                    width: 365,
                    child: MyField(
                      labelText: "Price",
                      controller: priceController,
                      prefixIcon: const Icon(Icons.price_change),
                    ),
                  ),
                  Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Category',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        //selected value
                        value: categoryController.selectedCategory.value,
                        //fetching data from Category Controller
                        items: categoryController.categories.value
                            .map((item) => DropdownMenuItem<Category>(
                                  value: item,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          categoryController.selectedCategory.value =
                              value as Category;
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey[200],
                        buttonHeight: 50,
                        buttonWidth: 355,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                        buttonDecoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.grey,
                        ),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 200,
                        dropdownPadding: null,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.grey[200],
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ))),
                  const SizedBox(height: 15),
                  // //to make container clickable use INKWELL
                  InkWell(
                      //port where image selected
                      onTap: () async {
                        pickedFile =
                            await _picker.getImage(source: ImageSource.gallery);
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
                          var result = await serviceCenterController
                              .getServiceCenterID();
                          //print(result);

                          var selectedCategory =
                              categoryController.selectedCategory.toJson();

                          if (_formKey.currentState!.validate()) {
                            var data = {
                              "name": _nameController.text,
                              "description": _descriptionController.text,
                              "price": priceController.text,
                              "categoryID": selectedCategory['id'].toString(),
                              "serviceCenter_id": result.toString()
                            };
                            print(data);
                            serviceController.add(data, pickedFile);
                          }
                        },
                        buttonName: 'Add'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
