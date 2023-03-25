import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/authentication_controller.dart';
import 'package:service_center/controller/city_controller.dart';
import 'package:service_center/model/city_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/views/components/my_button.dart';
import 'package:service_center/views/components/my_field.dart';
import 'package:service_center/views/pages/login_page.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController = TextEditingController();

  final contactNoController = TextEditingController();

  final emailController = TextEditingController();

  final addressController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final authentication = Get.find<Authentication>();

  final formKey = GlobalKey<FormState>();

  final CitiesController categoryController = Get.find<CitiesController>();

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  const Text("Create a New Account",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 39, 39, 57))),
                  const SizedBox(height: 15),
                  MyField(
                    controller: nameController,
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person),
                    myTextValidator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  MyField(
                    controller: contactNoController,
                    labelText: 'Contact Number',
                    prefixIcon: const Icon(Icons.phone),
                    myTextValidator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
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
                                'Select City',
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
                        value: CitiesController.selectedCity.value,
                        //fetching data from Cities Controller
                        items: CitiesController.cities.value
                            .map((item) => DropdownMenuItem<Cities>(
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
                          CitiesController.selectedCity.value = value as Cities;
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey[200],
                        buttonHeight: 50,
                        buttonWidth: 385,
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
                        dropdownWidth: 400,
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
                  MyField(
                    controller: addressController,
                    labelText: 'Address',
                    prefixIcon: const Icon(Icons.location_on),
                    myTextValidator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  MyField(
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'xyz@gmail.com',
                    prefixIcon: const Icon(Icons.email),
                    myTextValidator: (value) {
                      if (!value.toString().contains("@gmail.com")) {
                        return "Email is not valid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  MyField(
                    controller: usernameController,
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    myTextValidator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  MyField(
                    controller: passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.password),
                    myTextValidator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  MyField(
                    controller: confirmPasswordController,
                    labelText: 'Confirm Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock),
                    myTextValidator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 70,
                    width: 200,
                    child: MyButton(
                        onTap: () {
                          var isFormValid = formKey.currentState!.validate();
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            var selectedCity =
                                CitiesController.selectedCity.toJson();
                            if (isFormValid) {
                              var data = {
                                "name": nameController.text,
                                "phone": contactNoController.text,
                                "address": addressController.text,
                                "city_id": selectedCity['id'].toString(),
                                "email": emailController.text,
                                "userName": usernameController.text,
                                "password": passwordController.text
                              };
                              authentication.signup(data);
                            }
                          } else {
                            showMessage(
                                title: "Error",
                                message: "Incorrect Password",
                                isSuccess: false);
                          }
                        },
                        buttonName: "Submit"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () => Get.to(LoginPage()),
                    child: const Text("Sign in",
                        style: TextStyle(
                          color: Color.fromARGB(255, 26, 44, 48),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  onTap() {}
}
