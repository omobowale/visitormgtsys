import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/confirmation_modal.dart';
import 'package:vms/views/view.dart';

class TopSection extends StatelessWidget {
  final String leftText;
  bool showButton;
  final String rightText;

  TopSection(
      {Key? key,
      this.showButton = true,
      required this.leftText,
      required this.rightText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              leftText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          !showButton
              ? Container()
              : CustomTextWithBackground(
                  text: rightText,
                  textColor: Palette.FBN_BLUE,
                  backgroundColor: Color.fromRGBO(0, 59, 101, 0.05),
                  fn: () {
                    showModalBottomSheet<void>(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationModal(
                              confirmationTextTitle: "Are you sure?",
                              confirmationTextDescription:
                                  "You are about to cancel this process, you will have to restart it again",
                              declineFunction: () {
                                Navigator.of(context).pop();
                              },
                              acceptFunction: () {
                                context
                                    .read<AppointmentNotifier>()
                                    .setIsCreating = false;
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/view', (route) => false);
                              });
                        });
                  },
                ),
        ],
      ),
    );
  }
}
