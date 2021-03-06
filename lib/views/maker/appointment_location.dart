import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_input_field_disabled.dart';
import 'package:vms/helperfunctions/appointmentDetailsExtractor.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/created_location.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/location.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/appointment_location/room.dart';
import 'package:vms/services/location_service.dart';
import 'package:vms/partials/appointment_location/floor.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/common/top.dart';

class AppointmentLocation extends StatefulWidget {
  const AppointmentLocation({Key? key}) : super(key: key);

  @override
  State<AppointmentLocation> createState() => _AppointmentLocationState();
}

class _AppointmentLocationState extends State<AppointmentLocation> {
  LocationService get service => GetIt.I<LocationService>();
  late APIResponse<List<CreatedLocation>> _locationsList;
  late AppointmentNotifier _appointmentNotifier;
  late List<Floor> _floorsList;
  List<Location> fallbackLocation = [
    Location(floors: [], id: 1, name: "Others")
  ];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    service.getLocations().then((response) {
      setState(() {
        _locationsList = response;
        var data = _locationsList.data ?? [];
        if (_appointmentNotifier.appointments[0].meetingRoom.isEmpty) {
          var meetingRooms = getRooms(data);
          _appointmentNotifier.addMeetingRoom(meetingRooms[0]);
          _appointmentNotifier
              .addFloor(getFloorFromRoomName(data, meetingRooms[0]));
          _appointmentNotifier.addLocationDetails(
              getLocationDetailsFromRoomName(data, meetingRooms[0]));
          print(
              "location detals: ${getLocationDetailsFromRoomName(data, meetingRooms[0])}");
          _appointmentNotifier.removeError("meetingRoom");
          _appointmentNotifier.removeError("floor");
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Palette.FBN_BLUE,
              ),
            ),
          )
        : Scaffold(
            body: ListView(
              children: [
                TopSection(leftText: "Select Location", rightText: "Cancel"),
                // Divider(),
                _locationsList.data != null
                    ? Column(
                        children: [
                          RoomSection(
                            labelText: "Room",
                            locationsList: _locationsList.data!,
                            roomsList: getRooms(_locationsList.data!),
                          ),
                          FloorSection(
                            labelText: "Floor",
                            valueText: context
                                    .watch<AppointmentNotifier>()
                                    .appointments[0]
                                    .floor
                                    .isEmpty
                                ? getFloorFromRoomName(_locationsList.data!,
                                    getRooms(_locationsList.data!)[0])
                                : context
                                    .watch<AppointmentNotifier>()
                                    .appointments[0]
                                    .floor,
                          ),
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.all(20),
                        child: CustomInputFieldDisabled(
                          text: "Unable to fetch locations",
                        ),
                      ),
                Divider(),
                BottomFixedSection(
                  leftText: "Back",
                  rightText: "Continue",
                  fnOne: () {
                    Navigator.pushNamed(context, '/new_appointment');
                  },
                  fnTwo: () {
                    context.read<AppointmentNotifier>().showAppointment(
                        context.read<AppointmentNotifier>().appointments[0]);

                    context.read<AppointmentNotifier>().locationValid();
                    if (context
                        .read<AppointmentNotifier>()
                        .allLocationErrors
                        .isEmpty) {
                      Navigator.pushNamed(context, '/visitor_information');
                    }
                  },
                )
              ],
            ),
          );
  }
}
