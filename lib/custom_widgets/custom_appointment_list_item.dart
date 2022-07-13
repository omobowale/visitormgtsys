import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/models/screen_arguments.dart';
import 'package:vms/views/maker/details.dart';

class AppointmentListItem extends StatefulWidget {
  final String appointmentId;
  final String startTime;
  final String endTime;
  final String appointmentType;
  final String visitorName;
  final bool isGroupVisit;
  final bool isApproved;
  final bool isCancelled;

  const AppointmentListItem({
    Key? key,
    required this.appointmentId,
    required this.startTime,
    required this.endTime,
    required this.appointmentType,
    required this.visitorName,
    required this.isGroupVisit,
    required this.isApproved,
    required this.isCancelled,
  }) : super(key: key);

  @override
  State<AppointmentListItem> createState() => _AppointmentListItemState();
}

class _AppointmentListItemState extends State<AppointmentListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details',
            arguments:
                ScreenArguments(widget.appointmentId, widget.isApproved));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 2,
                    color: widget.isGroupVisit
                        ? Colors.grey.withOpacity(0.3)
                        : Colors.green,
                  ),
                ),
                color: Palette.CUSTOM_WHITE,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 3, left: 8),
                    child: Text(
                      widget.startTime.toString() +
                          " - " +
                          widget.endTime.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          widget.appointmentType,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.circle,
                          size: 8,
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.visitorName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.isApproved
                ? Icon(
                    Icons.approval_sharp,
                    color: Palette.FBN_GREEN,
                  )
                : widget.isCancelled
                    ? Icon(
                        Icons.block,
                        color: Colors.red,
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
