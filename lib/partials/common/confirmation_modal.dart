import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/views/view.dart';

class ConfirmationModal extends StatelessWidget {
  final String confirmationTextTitle;
  final String confirmationTextDescription;
  final Function acceptFunction;
  final Function declineFunction;
  const ConfirmationModal({
    Key? key,
    required this.confirmationTextTitle,
    required this.confirmationTextDescription,
    required this.acceptFunction,
    required this.declineFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: Palette.CUSTOM_WHITE,
      ),
      padding: EdgeInsets.only(
        bottom: 0,
        top: 50,
        // left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              confirmationTextTitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Text(
              confirmationTextDescription,
            ),
          ),
          BottomFixedSection(
            leftText: "No",
            rightText: "Yes",
            fnOne: () {
              declineFunction();
            },
            fnTwo: () {
              acceptFunction();
            },
          )
        ],
      ),
    );
  }
}
