import 'package:flutter/material.dart';

class TimeStamp extends StatelessWidget {
  final String time;
  final String date;
  const TimeStamp({Key? key, required this.date, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          Container(
            child: Icon(Icons.calendar_month),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Text(date),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Text(time),
          ),
        ],
      ),
    );
  }
}
