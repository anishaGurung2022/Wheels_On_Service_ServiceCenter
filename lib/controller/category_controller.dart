import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_center/model/category_model.dart';
import 'package:service_center/utils/api.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';

class CategoryController extends GetxController {
  var loading = false.obs;
  var selectedCategory = Category(id: "", name: "", description: "").obs;

  //getting the category details by creating model
  var categories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    get();
  }

  final AuthService authService = AuthService();

  //GET categories from database
  get() async {
    var url = Uri.parse(GET_CATEGORIES_API);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body); //as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        var responseData = jsonResponse['data'];
        for (var i = 0; i < responseData.length; i++) {
          categories.add(Category.fromJson(responseData[i]));
        }
        selectedCategory.value = categories.value[0];
        //print(categories);
        //Get.back();
        //showMessage(title: "Success", message: jsonResponse["message"]);
      } else {
        //showMessage(title: "Error", message: jsonResponse["message"], isSuccess: false);
      }
    }
  }
}
