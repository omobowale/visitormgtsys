import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String content;
  final String subcontent1;
  final String subcontent2;
  const CustomTile({
    Key? key,
    required this.title,
    required this.content,
    required this.subcontent1,
    required this.subcontent2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.person,
              color: Palette.LAVENDAR_GREY,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.email,
              color: Palette.LAVENDAR_GREY,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.phone,
              color: Palette.LAVENDAR_GREY,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              subcontent1,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.place,
              color: Palette.LAVENDAR_GREY,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              subcontent2,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        )
      ],
    );
  }
}
