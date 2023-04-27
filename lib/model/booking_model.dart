// To parse this JSON data, do
//
//     final bookings = bookingsFromJson(jsonString);

import 'dart:convert';

Bookings bookingsFromJson(String str) => Bookings.fromJson(json.decode(str));

String bookingsToJson(Bookings data) => json.encode(data.toJson());

class Bookings {
  Bookings({
    required this.id,
    required this.customer,
    required this.bookingDate,
    required this.status,
    required this.isPaid,
  });

  String id;
  String customer;
  DateTime bookingDate;
  String status;
  String isPaid;

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        id: json["id"],
        customer: json["customer"],
        bookingDate: DateTime.parse(json["booking_date"]),
        status: json["status_"],
        isPaid: json["is_paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer": customer,
        "booking_date": bookingDate.toIso8601String(),
        "status_": status,
        "is_paid": isPaid,
      };
}
