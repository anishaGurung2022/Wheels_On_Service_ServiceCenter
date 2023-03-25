import 'dart:convert';

import 'package:get/get.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;

class ServiceCenterController extends GetxController {
  var loading = false.obs;
  final AuthService authService = AuthService();

  void onInit() {
    super.onInit();
    getServiceCenterID();
  }

  getServiceCenterID() async {
    var url = Uri.parse(SERVICE_CENTER_ID);
    var token_ = await authService.getToken();
    var response = await http.post(url, body: {"token": token_});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        var serviceCenterID = jsonResponse['id'].toString();
        var result = Future(() => serviceCenterID);
        result.then((str) => (str));
        return result;
      } else {
        showMessage(
            title: "Error", message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}