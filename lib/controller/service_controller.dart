import 'dart:convert';
import 'dart:developer';
import 'package:get/get_connect/http/src/_http/_html/_file_decoder_html.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_center/model/service_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import '../utils/api.dart';

class ServiceController extends GetxController {
  var loading = false.obs;
  final AuthService authService = AuthService();
  var services = <Services>[].obs;

  void onInit() async {
    super.onInit();
    var token_ = await authService.getToken();
    get(token_);
  }

  get(token_) async {
    loading.value = true;
    var url = Uri.parse(GET_SERVICE_API);
    //var token_ = await authService.getToken();
    var response = await http.post(url, body: {"token": token_});
    loading.value = false;
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        services.value = (jsonResponse["data"] as List)
            .map((e) => Services.fromJson(e))
            .toList();
      } else {
        showMessage(
            message: jsonResponse["message"],
            isSuccess: false,
            title: 'Success');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  add(data, PickedFile? file) async {
    loading.value = true;
    //data['token'] = (await authService.getToken());
    var url = Uri.parse(ADD_SERVICE_API);

    //multipart that takes file
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data);
    print(data);
    if (file != null) {
      var pic = await http.MultipartFile.fromPath('image', file.path);
      request.files.add(pic);
      print(pic);
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
