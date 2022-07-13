import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_field.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/helperfunctions/custom_string_manipulations.dart';
import 'package:vms/models/visitor.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/visitor_information/visitor_address.dart';
import 'package:vms/partials/visitor_information/visitor_details.dart';
import 'package:vms/views/maker/appointment_location.dart';
import 'package:vms/views/maker/summary.dart';
import 'package:vms/views/view.dart';

class AddAnotherLink extends StatefulWidget {
  const AddAnotherLink({Key? key}) : super(key: key);

  @override
  State<AddAnotherLink> createState() => _AddAnotherLinkState();
}

class _AddAnotherLinkState extends State<AddAnotherLink> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String phoneNumber = "";

  @override
  Widget build(BuildContext ctx) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(ctx, listen: false);
    return GestureDetector(
      onTap: () async {
        await showTopModalSheet<String>(
          context: ctx,
          child: Container(
            color: Palette.CUSTOM_WHITE,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    child: Text(
                      "Add new guest",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                  CustomInputLabel(labelText: "Email"),
                  CustomInputField(
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter an email";
                        }
                        if (!CustomStringManipulation.validatEmail(value)) {
                          return "Please enter a valid email";
                        }
                        setState(() {
                          email = value;
                        });
                        return null;
                      },
                      hintText: "",
                      labelText: "",
                      bordered: false,
                      onComplete: (value) {}),
                  CustomInputLabel(labelText: "Phone Number"),
                  CustomInputField(
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Please enter a phone number";
                      }
                      if (!CustomStringManipulation.validatPhoneNumber(value)) {
                        return "Please enter a valid phone number";
                      }
                      setState(() {
                        phoneNumber = value;
                      });

                      return null;
                    },
                    hintText: "",
                    labelText: "",
                    bordered: false,
                    onComplete: (value) {},
                  ),
                  BottomFixedSection(
                    leftText: "Cancel",
                    rightText: "Add",
                    fnOne: () {
                      // context.read<AppointmentNotifier>().removeLastGuest();
                      Navigator.of(ctx).pop();
                    },
                    fnTwo: () {
                      if (_formKey.currentState!.validate()) {
                        //create new Guest
                        var currentGuests = ctx
                            .read<AppointmentNotifier>()
                            .appointments[0]
                            .guests;
                        var visitorType = ctx
                            .read<AppointmentNotifier>()
                            .appointments[0]
                            .appointmentType;
                        print("visitor type: ${visitorType}");
                        Visitor visitor = Visitor(
                          id: currentGuests.length.toString(),
                          firstName: "",
                          lastName: "",
                          address: "",
                          email: email,
                          phoneNumber: phoneNumber,
                          visitorType: 0,
                        );

                        _appointmentNotifier.addGuest(visitor);

                        Navigator.pushNamed(ctx, '/summary');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: Palette.FBN_BLUE,
            ),
            Text(
              "Add another guest",
              style: TextStyle(
                  color: Palette.FBN_BLUE, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
