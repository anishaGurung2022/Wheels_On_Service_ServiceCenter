// To parse this JSON data, do
//
//     final bookingDetails = bookingDetailsFromJson(jsonString);

import 'dart:convert';

BookingDetails bookingDetailsFromJson(String str) =>
    BookingDetails.fromJson(json.decode(str));

String bookingDetailsToJson(BookingDetails data) => json.encode(data.toJson());

class BookingDetails {
  String serviceName;
  String servicePrice;
  String status;

  BookingDetails({
    required this.serviceName,
    required this.servicePrice,
    required this.status,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        serviceName: json["service_name"],
        servicePrice: json["service_price"],
        status: json["status_"],
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "service_price": servicePrice,
        "status_": status,
      };
}
