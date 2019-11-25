import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:post_app/model/user/address_model.dart';
import 'package:post_app/model/user/company_model.dart';

class UserModel {
  
  int id;
  String name;
  String username;
  String email;
  AddressModel address;
  String phone;
  String website;
  CompanyModel company;

  UserModel({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.email,
    @required this.address,
    @required this.phone,
    @required this.website,
    @required this.company,
  });
  
  UserModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    username = jsonData['username'];
    email = jsonData['email'];
    address = AddressModel.fromJson(jsonData['address'] is String
        ? json.decode(jsonData['address'])
        : jsonData['address']);
    phone = jsonData['phone'];
    website = jsonData['website'];
    company = CompanyModel.decodeJson(jsonData['company'] is String
        ? json.decode(jsonData['company'])
        : jsonData['company']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': address.toJsonString(),
      'phone': phone,
      'website': website,
      'company': company.toJsonString(),
    };
  }
}
