import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:service_center/model/booking_details_model.dart';
import 'package:service_center/model/booking_model.dart';
import 'package:service_center/utils/constants.dart';
import 'package:service_center/utils/shared_prefs.dart';
import '../utils/api.dart';

class BookingController extends GetxController {
  var loading = false.obs;
  final AuthService authService = AuthService();
  var bookings = <Bookings>[].obs;
  var bookingDetails = <BookingDetails>[].obs;
  List<Bookings> get bookingsList => bookings.toList();
  List<BookingDetails> get bookingDetailsList => bookingDetails.toList();

  @override
  void onInit() async {
    super.onInit();
    var token_ = await authService.getToken();
    get(token_);
  }

  get(token_) async {
    loading.value = true;
    var url = Uri.parse(GET_BOOKINGS_API);
    var response = await http.post(url, body: {"token": token_});
    loading.value = false;
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        var responseData = jsonResponse['data'];
        for (var i = 0; i < responseData.length; i++) {
          bookings.add(Bookings.fromJson(responseData[i]));
        }
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

  getBookingDetails(id) async {
    loading.value = true;
    var url = Uri.parse(GET_BOOKING_DETAILS_API);
    var response = await http.post(url, body: {"id": id});
    loading.value = false;
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        var responseData = jsonResponse['data'];
        for (var i = 0; i < responseData.length; i++) {
          bookingDetails.add(BookingDetails.fromJson(responseData[i]));
        }
        print(responseData);
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
}
