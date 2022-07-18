import 'package:flutter/material.dart';

class Visitor with ChangeNotifier {
  int id;
  String firstName;
  String lastName;
  String email;
  String address;
  String phoneNumber;
  String visitorType;
  bool hasPersonalAsset;

  Visitor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.visitorType,
    this.hasPersonalAsset = true,
  });

  factory Visitor.emptyOne() {
    return Visitor(
      id: 0,
      firstName: "",
      lastName: "",
      address: "",
      email: "",
      phoneNumber: "",
      visitorType: "",
      hasPersonalAsset: true,
    );
  }

  set setId(String id) {
    id = id;
    notifyListeners();
  }

  set setFirstName(String firstName) {
    firstName = firstName;
    notifyListeners();
  }

  set setPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber;
    notifyListeners();
  }

  set setEmail(String email) {
    email = email;
    notifyListeners();
  }

  bool isValid() {
    if (email != null &&
        email != "" &&
        phoneNumber != null &&
        phoneNumber != "") {
      return true;
    }

    return false;
  }

  @override
  String toString() {
    return "{first name: $firstName, id: $id, last name: $lastName, address: $address, email: $email, phone: $phoneNumber, visitorType: $visitorType}";
  }

  Map<String, dynamic> toMap() {
    print("visitorType here: ${visitorType}");
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
      "visitorType": int.tryParse(visitorType) ?? 0,
      "hasPersonalAsset": true,
    };
  }

  static Visitor fromMap(Map<String, dynamic> visitor) {
    return Visitor(
      phoneNumber: visitor["phoneNumber"],
      address: visitor["address"],
      email: visitor["email"],
      firstName: visitor["firstName"],
      lastName: visitor["lastName"],
      id: visitor["id"],
      visitorType: visitor["visitorType"],
      hasPersonalAsset: visitor["hasPersonalAsset"],
    );
  }

  static List<Visitor> convertVisitorMapsToVisitorObjects(
      List<dynamic> visitors) {
    Iterable<Visitor> v = visitors.map((visitor) {
      if (visitor is Map<String, dynamic>) {
        return fromMap(visitor);
      }
      return visitor;
    });

    return v.toList();
  }
}
