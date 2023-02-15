import 'dart:convert';

import 'package:get/get.dart';
import 'package:service_center/model/city_model.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;

class CitiesController extends GetxController {
  var loading = false.obs;
  static var selectedCity = Cities(id: "", name: "").obs;

  //getting the category details by creating model
  static var cities = <Cities>[].obs;

  @override
  void onInit() {
    super.onInit();
    get();
  }

  final AuthService authService = AuthService();

  //GET categories from database
  get() async {
    var url = Uri.parse(GET_CITIES_API);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        var responseData = jsonResponse['data'];
        for (var i = 0; i < responseData.length; i++) {
          cities.add(Cities.fromJson(responseData[i]));
        }
        selectedCity.value = cities.value[0];
        Get.back();
        //showMessage(title: "Success", message: jsonResponse["message"]);
      } else {
        //showMessage(title: "Error", message: jsonResponse["message"], isSuccess: false);
      }
    }
  }
}
