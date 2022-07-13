import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_appointment_day_date.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class NoAppointment extends StatelessWidget {
  final DateTime selectedDate;
  const NoAppointment({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 5),
      child: Column(
        children: [
          AppointmentDayDate(
            selectedDate: selectedDate,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // margin: EdgeInsets.only(left: 12, right: 12, bottom: 20, top: 0),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Color(0xffF0F4FA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xffE2E4E8),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No appointments",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text("Create an appointment"),
                  ],
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/new_appointment');
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.8,
          ),
        ],
      ),
    );
  }
}
