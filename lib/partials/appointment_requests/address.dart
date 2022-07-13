import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  final String address;
  const Address({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: Row(children: [
        Container(
          child: Icon(Icons.location_city),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          child: Text(address),
        )
      ]),
    );
  }
}
