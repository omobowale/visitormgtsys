import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class Guests extends StatelessWidget {
  final int noOfGuests;
  const Guests({Key? key, required this.noOfGuests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          Container(
            child: Icon(Icons.people),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Text("$noOfGuests ${noOfGuests > 1 ? "Guests" : "Guest"}"),
          ),
          Container(
            child: Icon(
              Icons.arrow_right,
              color: Palette.FBN_BLUE,
            ),
          ),
        ],
      ),
    );
  }
}
