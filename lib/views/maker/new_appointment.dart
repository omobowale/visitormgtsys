import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/enumeration.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/new_appointment/date_time.dart';
import 'package:vms/partials/new_appointment/group_head_search.dart';
import 'package:vms/partials/new_appointment/host_name_search.dart';
import 'package:vms/partials/new_appointment/host_section.dart';
import 'package:vms/partials/new_appointment/visit_purpose.dart';
import 'package:vms/partials/common/top.dart';
import 'package:vms/partials/new_appointment/visitor_type.dart';
import 'package:vms/services/enum_service.dart';
import 'package:vms/views/view.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  EnumService get service => GetIt.I<EnumService>();

  late APIResponse<List<Enumeration>> _enumList;
  bool visitPurposeLoading = false;
  bool visitorTypeLoading = false;
  List<Map<String, dynamic>> visitPurposesList = [];
  List<Map<String, dynamic>> visitorTypesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visitPurposesList = getAndSetEnumeration(
        context.read<LoginLogoutNotifier>().allEnums, "purposeEnum");
    visitorTypesList = getAndSetEnumeration(
        context.read<LoginLogoutNotifier>().allEnums, "visitorTypeEnum");
  }

  @override
  Widget build(BuildContext context) {
    //This will begin a new process if it has not already begun
    context.read<AppointmentNotifier>().addEmptyAppointment();
    return Scaffold(
      body: visitPurposeLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Palette.FBN_BLUE,
              ),
            )
          : ListView(
              children: [
                TopSection(
                  leftText: "New Appointment",
                  rightText: "Cancel",
                ),
                Divider(),
                VisitorType(visitorTypesList: visitorTypesList),
                Divider(),
                VisitPurpose(visitPurposesList: visitPurposesList),
                Divider(),
                CustomHostName(),
                Divider(),
                CustomGroupHead(),
                Divider(),
                DateTimeSection(),
                Divider(),
                BottomFixedSection(
                    leftText: "Back",
                    rightText: "Continue",
                    fnOne: () {
                      Navigator.pushNamed(context, '/view');
                    },
                    fnTwo: () {
                      context.read<AppointmentNotifier>().newAppointmentValid();
                      if (context
                          .read<AppointmentNotifier>()
                          .allNewAppointmentErrors
                          .isEmpty) {
                        Navigator.pushNamed(context, '/appointment_location');
                      }
                    }),
              ],
            ),
    );
  }
}
