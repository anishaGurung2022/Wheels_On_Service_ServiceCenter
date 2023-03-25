import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import '../utils/api.dart';

class ServiceController extends GetxController {
  var loading = false.obs;
  final AuthService authService = AuthService();

  void onInit() {
    super.onInit();
    //var products = get();
  }

  // get() async {
  //   var url = Uri.parse(GET_PRODUCTS_API);
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //     if (jsonResponse["success"]) {
  //       Get.back();
  //       showMessage(title: "Success", message: jsonResponse["message"]);
  //     } else {
  //       showMessage(
  //           title: "Error", message: jsonResponse["message"], isSuccess: false);
  //     }
  //   }
  // }

  add(data, PickedFile? file) async {
    loading.value = true;
    data['token'] = (await authService.getToken());
    var url = Uri.parse(ADD_SERVICE_API);
    //multipart that takes file
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data);
    print(file);
    if (file != null) {
      var pic = await http.MultipartFile.fromPath('image', file.path);
      request.files.add(pic);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(await response.stream.bytesToString());
      if (decodedResponse['success']) {
        Get.back();
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
