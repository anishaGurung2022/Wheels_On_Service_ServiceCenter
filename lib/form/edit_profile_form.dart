import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_center/controller/category_controller.dart';
import 'package:service_center/controller/service_controller.dart';
import 'package:service_center/controller/serviceCenter_controller.dart';
import 'package:service_center/model/serviceCenter_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import 'package:service_center/views/components/my_button.dart';
import 'package:service_center/views/components/my_field.dart';

class EditProfileForm extends StatefulWidget {
  final ServiceCenter serviceCenter;
  const EditProfileForm({super.key, required this.serviceCenter});

  @override
  State<EditProfileForm> createState() => EditProfileFormState();
}

class EditProfileFormState extends State<EditProfileForm> {
  final ImagePicker _picker = ImagePicker();
  AuthService authService = AuthService();
  PickedFile? pickedFile;
  String? _imageUrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final ServiceController serviceController = Get.put(ServiceController());
  final ServiceCenterController serviceCenterController =
      Get.put(ServiceCenterController());
  final CategoryController categoryController = Get.find<CategoryController>();
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _idController.text = widget.serviceCenter.id;
    _nameController.text = widget.serviceCenter.name;
    _phoneController.text = widget.serviceCenter.phone;
    _usernameController.text = widget.serviceCenter.userName;
    _addressController.text = widget.serviceCenter.address;
    _imageUrl = widget.serviceCenter.image;
  }

  EditProfileFormState();
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
            "Edit Profile",
            style: TextStyle(
                fontSize: 25,
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
                              labelText: "Service Center Name",
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
                            labelText: "Contact Number",
                            controller: _phoneController,
                            hintText: _phoneController.text,
                            prefixIcon: const Icon(Icons.description),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 365,
                          child: MyField(
                            labelText: "User name",
                            controller: _usernameController,
                            hintText: _usernameController.text,
                            prefixIcon: const Icon(Icons.person_add),
                          ),
                        ),
                        SizedBox(
                          width: 365,
                          child: MyField(
                            labelText: "Address",
                            controller: _addressController,
                            hintText: _addressController.text,
                            prefixIcon:
                                const Icon(Icons.location_history_sharp),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(height: 15),

                        // //to make container clickable use INKWELL
                        InkWell(
                            //port where image selected
                            onTap: () async {
                              pickedFile = await _picker.getImage(
                                  source: ImageSource.gallery);
                              setState(() {});
                              if (pickedFile != null) {
                                Get.back();
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
                                    "phone": _phoneController.text,
                                    "userName": _usernameController.text,
                                    "address": _addressController.text,
                                  };
                                  print(data);
                                  serviceCenterController.updateProfile(
                                      data, pickedFile);
                                }
                              },
                              buttonName: 'Add'),
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
