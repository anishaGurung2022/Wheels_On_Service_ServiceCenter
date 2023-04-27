import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_center/model/serviceCenter_model.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;

class ServiceCenterController extends GetxController {
  //var loading = false.obs;
  final AuthService authService = AuthService();
  var serviceCenterDetails = <ServiceCenter>[].obs;

  void onInit() async {
    super.onInit();
    var token_ = await authService.getToken();
    getServiceCenterDetails(token_);
    getServiceCenterID();
  }

  getServiceCenterID() async {
    try {
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
              title: "Error",
              message: jsonResponse["message"],
              isSuccess: false);
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  getServiceCenterDetails(token_) async {
    var url = Uri.parse(SERVICE_CENTER_DETAILS);
    //var token_ = await authService.getToken();
    var response = await http.post(url, body: {"token": token_});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        print(jsonResponse);
        serviceCenterDetails.value = (jsonResponse["data"] as List)
            .map((e) => ServiceCenter.fromJson(e))
            .toList();
      } else {
        showMessage(
            title: "Error", message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  updateProfile(data, PickedFile? file) async {
    //loading.value = true;
    data['token'] = (await authService.getToken());
    var url = Uri.parse(EDIT_PROFILE_API);

    //multipart that takes file
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data);
    print(data);
    if (file != null) {
      var pic = await http.MultipartFile.fromPath('image', file.path);
      request.files.add(pic);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(await response.stream.bytesToString());
      if (decodedResponse['success']) {
        Get.back();
        getServiceCenterDetails(await authService.getToken());
        showMessage(message: decodedResponse["message"], title: 'Success');
      } else {
        showMessage(
            message: decodedResponse["message"],
            isSuccess: false,
            title: 'Error');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
