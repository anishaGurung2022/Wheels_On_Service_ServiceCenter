import 'dart:convert';
import 'package:get/get.dart';
import 'package:service_center/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import 'package:service_center/views/pages/loader.dart';
import 'package:service_center/views/pages/login_page.dart';

class Authentication extends GetxController {
  final authService = AuthService();

  login(data) async {
    var url = Uri.parse(LOGIN_API);
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      // Converting json response into Map (list with key and its value)
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        //when success is true save token in ROM
        await authService.saveToken(jsonResponse["token"]);
        Get.offAll(const Loader());
        showMessage(
            title: "Success",
            message: jsonResponse["message"],
            isSuccess: true);
      } else {
        showMessage(
            title: "Error", message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  signup(data) async {
    var url = Uri.parse(SIGNUP_API);
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        Get.offAll(LoginPage());
        showMessage(
            title: "Success",
            message: jsonResponse["message"],
            isSuccess: true);
      } else {
        showMessage(
            title: "Error", message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
