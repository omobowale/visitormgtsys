import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_drop_down.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class FloorSection extends StatelessWidget {
  final String labelText;
  List<Floor> floorsList;
  FloorSection({Key? key, required this.labelText, required this.floorsList})
      : super(key: key);

  List<dynamic> extractFloors(List<Floor>? floors) {
    if (floors != null) {
      List<dynamic> floorNames = floors
          .map(
            (e) => e.name,
          )
          .toList();
      return floorNames;
    }

    return [];
  }

  Floor getFloorByName(List<Floor>? floors, String name) {
    try {
      if (floors != null) {
        return floors.firstWhere((element) => element.name == name);
      }
      return Floor.emptyOne();
    } on StateError {
      return Floor.emptyOne();
    }
  }

  @override
  Widget build(BuildContext context) {
    Floor floor = context.watch<AppointmentNotifier>().appointments[0].floor;

    String floorName = floor.isValid() ? floor.name : floorsList[0].name;

    List<Floor> listOfFloors =
        context.watch<AppointmentNotifier>().appointments[0].location.floors;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputLabel(labelText: "Floor"),
          CustomErrorLabel(
              errorText: context
                  .read<AppointmentNotifier>()
                  .allLocationErrors["floor"]),
          CustomDropDown(
            onTap: (value) {
              context.read<AppointmentNotifier>().addFloor(getFloorByName(
                  context
                      .read<AppointmentNotifier>()
                      .appointments[0]
                      .location
                      .floors,
                  value));

              context.read<AppointmentNotifier>().removeError("floor");
            },
            text: floorName,
            lists: (extractFloors(listOfFloors)).toSet(),
          ),
        ],
      ),
    );
  }
}
