import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class CustomDateTimeSelector extends StatelessWidget {
  final Function onTap;
  final String selectedText;
  final Icon icon;
  const CustomDateTimeSelector(
      {Key? key,
      required this.onTap,
      required this.icon,
      required this.selectedText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.LAVENDAR_GREY,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
