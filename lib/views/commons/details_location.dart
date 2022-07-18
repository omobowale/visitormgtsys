import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_text_title.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/location.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class DetailsSummaryLocation extends StatefulWidget {
  final String? floor;
  final String? location;

  final String? meetingRooms;

  const DetailsSummaryLocation({
    Key? key,
    this.location,
    this.floor,
    this.meetingRooms,
  }) : super(key: key);

  @override
  State<DetailsSummaryLocation> createState() => _DetailsSummaryLocationState();
}

class _DetailsSummaryLocationState extends State<DetailsSummaryLocation> {
  late String location;
  late String floor;
  late String meetingRooms;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    location = widget.location ?? '';
    meetingRooms = widget.meetingRooms ?? '';
    floor = widget.floor ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextTitle(title: "Location"),
          Text(
            "${location} [${floor}]",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          ...meetingRooms.split(',').map(
            (e) {
              return Text(
                e,
                style: TextStyle(),
              );
            },
          )
        ],
      ),
    );
  }
}
