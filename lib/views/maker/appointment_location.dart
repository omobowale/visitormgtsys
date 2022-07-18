import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_input_field_disabled.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/location.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/appointment_location/roomlist.dart';
import 'package:vms/services/location_service.dart';
import 'package:vms/partials/appointment_location/floor.dart';
import 'package:vms/partials/appointment_location/location.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/common/top.dart';

class AppointmentLocation extends StatefulWidget {
  const AppointmentLocation({Key? key}) : super(key: key);

  @override
  State<AppointmentLocation> createState() => _AppointmentLocationState();
}

class _AppointmentLocationState extends State<AppointmentLocation> {
  LocationService get service => GetIt.I<LocationService>();
  late APIResponse<List<Location>> _locationsList;
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
    setState(() {
      isLoading = true;
    });

    _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: false);
    print("here now");
    service.getLocations().then((response) {
      print("here 2");
      setState(() {
        _locationsList = response;
        getRooms(_locationsList.data!);
        getFloorFromRoomName(_locationsList.data!, "Meeting Room A (by CBG)");
        print("i got here");
        print("location list data: ${_locationsList.data}");
        if (!_appointmentNotifier.appointments[0].location.isValid()) {
          _appointmentNotifier.addLocation(_locationsList.data![0]);
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  List<dynamic> getRooms(List<dynamic> locations) {
    print("location rooms: ${locations[0].floors[0].meetingRooms}");
    List<dynamic> rooms = [];

    locations.forEach((l) {
      l.floors.forEach((f) {
        f.meetingRooms.forEach((r) {
          rooms.add(r["name"]);
        });
      });
    });

    print("rooms are ${rooms}");

    return rooms;
  }

  String getFloorFromRoomName(List<dynamic> locations, String roomName) {
    dynamic floor;
    try {
      locations.forEach((l) {
        l.floors.forEach((f) {
          f.meetingRooms.forEach((r) {
            if (r["name"] == roomName) {
              floor = f;
            }
          });
        });
      });
      return floor.name;
    } on Error {
      return '';
    }
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
                          LocationSection(
                            labelText: "Location",
                            locationsList: _locationsList.data!,
                          ),
                          FloorSection(
                              labelText: "Floor",
                              floorsList: _locationsList.data![0].floors),
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.all(20),
                        child: CustomInputFieldDisabled(
                          text: "Unable to fetch locations",
                        ),
                      ),
                // Room(onComplete: (value) {
                //   _appointmentNotifier.addMeetingRoom(value);
                // }),

                RoomsList(
                    roomsList: _locationsList.data![0].floors[0].meetingRooms),
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
