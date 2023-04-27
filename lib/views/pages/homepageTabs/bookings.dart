import 'package:flutter/material.dart';
import 'package:service_center/controller/booking_controller.dart';
import 'package:service_center/utils/constants.dart';
import 'package:get/get.dart';
import 'package:service_center/views/components/booking_component.dart';

class BookingPage extends StatelessWidget {
  final BookingController _bookingController = Get.put(BookingController());
  BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call the method that sets the loading value before building the widget
    _bookingController.bookings();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("My Bookings"),
            backgroundColor: primaryColor,
          ),
          body: Obx(() {
            // Check the loading value in the controller
            if (_bookingController.loading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final bookings = _bookingController.bookingsList;
              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return BookingComponent(bookings: booking, number: index + 1);
                },
              );
            }
          })),
    );
  }
}
