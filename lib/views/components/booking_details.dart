import 'package:flutter/material.dart';
import 'package:service_center/model/booking_details_model.dart';
import 'package:service_center/utils/constants.dart';

class BookingDetailsPage extends StatelessWidget {
  final List<BookingDetails> bookingDetailsList;

  const BookingDetailsPage({Key? key, required this.bookingDetailsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemCount: bookingDetailsList.length,
        itemBuilder: (BuildContext context, int index) {
          final bookingDetails = bookingDetailsList[index];
          return BookingDetailsWidget(bookingDetails: bookingDetails);
        },
      ),
    );
  }
}

class BookingDetailsWidget extends StatelessWidget {
  final BookingDetails bookingDetails;

  const BookingDetailsWidget({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Service Name: ${bookingDetails.serviceName}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Price: ${bookingDetails.servicePrice}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Status: ${bookingDetails.status}"),
              )
            ],
          )
        ],
      ),
    );
  }
}
