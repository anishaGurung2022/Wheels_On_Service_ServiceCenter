import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/authentication_controller.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import 'package:service_center/views/components/my_button.dart';
import 'package:service_center/views/components/my_field.dart';
import 'package:service_center/views/pages/signup_page.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // final authentication = Get.put(Authentication());
  final authentication = Get.find<Authentication>();
  final AuthService authService = AuthService();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //const SizedBox(height: 20),
                Container(
                    height: 250,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.jpg'),
                              fit: BoxFit.fill)),
                    )),
                const Text("Sign In",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                const SizedBox(height: 20),
                MyField(
                  controller: emailController,
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  myTextValidator: (value) {
                    if (!value.toString().contains("@")) {
                      return "Email is not valid";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                MyField(
                  controller: passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  myTextValidator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 70,
                  width: 200,
                  child: MyButton(
                      onTap: () {
                        var isFormValid = formKey.currentState!.validate();
                        if (isFormValid) {
                          var data = {
                            "email": emailController.text,
                            "password": passwordController.text
                          };
                          authentication.login(data);
                        }
                      },
                      buttonName: "Login"),
                ),
                const SizedBox(height: 20),
                const Text("Don't have an account?",
                    style: TextStyle(fontSize: 20, color: textColor)),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.to(RegistrationPage());
                  },
                  child: const Text("Register Account",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
