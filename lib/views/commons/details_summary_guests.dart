import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_text_title.dart';
import 'package:vms/helperfunctions/custom_string_manipulations.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/summary_footer_timestamp.dart';
import 'package:vms/partials/common/summary_footer_timestamp_with_array.dart';

class DetailsSummaryGuests extends StatefulWidget {
  final List<dynamic>? guests;
  DetailsSummaryGuests({Key? key, this.guests}) : super(key: key);

  @override
  State<DetailsSummaryGuests> createState() => _DetailsSummaryGuestsState();
}

class _DetailsSummaryGuestsState extends State<DetailsSummaryGuests> {
  late List<dynamic> guests;
  late AppointmentNotifier _appointmentNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: false);
    guests = widget.guests ?? _appointmentNotifier.getValidGuests();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextTitle(title: "Guests (" + guests.length.toString() + ")"),
          ...guests.map(
            (e) {
              if (e.isValid()) {
                return Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 15,
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  (e.firstName != "" && e.lastName != "")
                                      ? "${CustomStringManipulation.getFullName(e.firstName, e.lastName)}"
                                      : " - ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          "${e.email}, ${e.phoneNumber}",
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
