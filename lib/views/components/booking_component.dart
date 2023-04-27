import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_center/controller/booking_controller.dart';
import 'package:service_center/model/booking_model.dart';
import 'package:service_center/views/components/booking_details.dart';

class BookingComponent extends StatefulWidget {
  final int number;
  final Bookings bookings;

  BookingComponent({
    Key? key,
    required this.number,
    required this.bookings,
  }) : super(key: key);

  @override
  State<BookingComponent> createState() => _BookingComponentState();
}

class _BookingComponentState extends State<BookingComponent> {
  BookingController bookingController = BookingController();

  @override
  void initState() async {
    super.initState();
    await bookingController.getBookingDetails(widget.bookings.id);
  }

  @override
  Widget build(BuildContext context) {
    var bookingDetailsList = bookingController.bookingDetailsList;
    return InkWell(
      onTap: (() =>
          Get.to(BookingDetailsPage(bookingDetailsList: bookingDetailsList))),
      child: Container(
        width: Get.width,
        height: 170,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: Colors.black, width: 0.5),
              boxShadow: const [BoxShadow()],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50, bottom: 0, right: 20, top: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 130, bottom: 0, right: 20, top: 0),
                        child: Text(
                          "#${widget.number}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50, bottom: 0, right: 20, top: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Customer Name:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.bookings.customer,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 100, bottom: 0, right: 20, top: 10),
                  child: Row(
                    children: const [
                      Text(
                        "Booking Date and time:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50, bottom: 0, right: 20, top: 10),
                  child: Text(
                    widget.bookings.bookingDate.toString(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
