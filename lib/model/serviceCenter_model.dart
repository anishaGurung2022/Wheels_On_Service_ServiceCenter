// To parse this JSON data, do
//
//     final serviceCenter = serviceCenterFromJson(jsonString);

import 'dart:convert';

ServiceCenter serviceCenterFromJson(String str) =>
    ServiceCenter.fromJson(json.decode(str));

String serviceCenterToJson(ServiceCenter data) => json.encode(data.toJson());

class ServiceCenter {
  ServiceCenter({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.cityId,
    required this.email,
    required this.userName,
    required this.password,
    required this.image,
  });

  String id;
  String name;
  String phone;
  String address;
  String cityId;
  String email;
  String userName;
  String password;
  String image;

  factory ServiceCenter.fromJson(Map<String, dynamic> json) => ServiceCenter(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        cityId: json["city_id"],
        email: json["email"],
        userName: json["userName"],
        password: json["password"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "city_id": cityId,
        "email": email,
        "userName": userName,
        "password": password,
        "image": image,
      };
}
