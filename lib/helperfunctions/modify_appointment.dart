import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/approve_appointment.dart';
import 'package:vms/models/cancel_appointment.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/reschedule_appointment.dart';
import 'package:vms/models/visitor.dart';

final PENDING = 0;
final APPROVE = 1;
final DENY = 2;
final CANCEL = 3;
final RESCHEDULE = 4;

List<dynamic> extractReasons(List<Map<String, dynamic>>? cancelPurposes) {
  if (cancelPurposes != null) {
    List<dynamic> reasons = cancelPurposes
        .map(
          (e) => e["name"],
        )
        .toList();
    return reasons;
  }

  return [];
}

bool canModify(DateTime endTime, bool isCancelled) {
  return endTime.isAfter(DateTime.now()) && !isCancelled;
}

cancelAppointment(
    CancelAppointment cancelDetails,
    dynamic service,
    dynamic context,
    String redirectLocation,
    Function setState,
    bool updateLoading) async {
  service.cancelAppointment(cancelDetails, context).then((result) {
    print("appointment id is : ${cancelDetails.visitId} ");
    print("result: ${result.data}");
    setState(() {
      updateLoading = false;
    });
    var title;
    var text;
    if (result.data != null) {
      title = "Success";
      text = "Appointment has been cancelled";
    } else {
      title = "Error";
      text = "Appointment could not be cancelled. Please try again later";
    }
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => updateLoading
          ? AlertDialog(
              content: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Palette.FBN_BLUE,
                  ),
                ),
              ),
            )
          : AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, redirectLocation);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Palette.FBN_BLUE,
                    ),
                  ),
                ),
              ],
            ),
    );
  });
}

rescheduleAppointment(
    RescheduleAppointment rescheduleDetails,
    dynamic service,
    dynamic context,
    String redirectLocation,
    Function setState,
    bool updateLoading) async {
  service.rescheduleAppointment(rescheduleDetails).then((result) {
    print("appointment id is : ${rescheduleDetails.visitId} ");
    setState(() {
      updateLoading = false;
    });
    var title;
    var text;
    if (result.data != null) {
      title = "Success";
      text = "Appointment has been rescheduled";
    } else {
      title = "Error";
      text = "Appointment could not be rescheduled. Please try again later";
    }
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => updateLoading
          ? AlertDialog(
              content: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Palette.FBN_BLUE,
                  ),
                ),
              ),
            )
          : AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, redirectLocation);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Palette.FBN_BLUE,
                    ),
                  ),
                ),
              ],
            ),
    );
  });
}

approveAppointment(
    ApproveAppointment approveDetails,
    dynamic service,
    dynamic context,
    String redirectLocation,
    Function setState,
    bool updateLoading) async {
  service.approveAppointment(approveDetails, context).then((result) {
    setState(() {
      updateLoading = false;
    });
    var title;
    var text;
    if (result.data != null) {
      title = "Success";
      text = "Appointment has been approved";
    } else {
      title = "Error";
      text = "Appointment could not be approved. Please try again later";
    }
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => updateLoading
          ? AlertDialog(
              content: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Palette.FBN_BLUE,
                  ),
                ),
              ),
            )
          : AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, redirectLocation);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Palette.FBN_BLUE,
                    ),
                  ),
                ),
              ],
            ),
    );
  });
}

modifyAppointment(
  int approveOrDeny,
  Appointment appointment,
  dynamic context,
  dynamic service,
  Function setState,
  bool updateLoading,
  String redirectLocation,
) async {
  String denied = "denied";
  String approved = "approved";
  String cancelled = "cancelled";
  String rescheduled = "rescheduled";

  String modifyText = "";

  if (approveOrDeny == APPROVE) {
    modifyText = approved;
  } else if (approveOrDeny == CANCEL) {
    modifyText = cancelled;
  } else if (approveOrDeny == RESCHEDULE) {
    modifyText = rescheduled;
  } else {
    modifyText = denied;
  }

  service.updateAppointment(appointment, appointment.id).then(
    (result) {
      print("appointment id is : ${appointment.id} ");
      setState(() {
        updateLoading = false;
      });
      var title;
      var text;
      if (result.data != null) {
        title = "Success";
        text = "Appointment has been $modifyText";
      } else {
        title = "Error";
        text = "Appointment could not be $modifyText. Please try again later";
      }
      showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => updateLoading
            ? AlertDialog(
                content: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Palette.FBN_BLUE,
                    ),
                  ),
                ),
              )
            : AlertDialog(
                title: Text(title),
                content: Text(text),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, redirectLocation);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Palette.FBN_BLUE,
                      ),
                    ),
                  ),
                ],
              ),
      );
    },
  );
}
