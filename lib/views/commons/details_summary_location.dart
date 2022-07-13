import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_text_title.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/location.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class DetailsSummaryLocation extends StatefulWidget {
  final Floor? floor;
  final Location? location;
  final List<dynamic>? roomNumbers;
  final String? meetingRoom;

  const DetailsSummaryLocation({
    Key? key,
    this.location,
    this.floor,
    this.roomNumbers,
    this.meetingRoom,
  }) : super(key: key);

  @override
  State<DetailsSummaryLocation> createState() => _DetailsSummaryLocationState();
}

class _DetailsSummaryLocationState extends State<DetailsSummaryLocation> {
  List<dynamic> rooms = [];
  late Location location;
  late Floor floor;
  late String meetingRoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rooms = widget.roomNumbers ??
        context.read<AppointmentNotifier>().appointments[0].rooms;
    location = widget.location ??
        context.read<AppointmentNotifier>().appointments[0].location;
    meetingRoom = widget.meetingRoom ??
        context.read<AppointmentNotifier>().appointments[0].meetingRoom;
    floor = widget.floor ??
        context.read<AppointmentNotifier>().appointments[0].floor;
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
            "${location.name} [${floor.name}]",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "${meetingRoom}",
            style: TextStyle(),
          ),
          // ...rooms.map(
          //   (e) {
          //     return Text(
          //       e.name,
          //       style: TextStyle(),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
