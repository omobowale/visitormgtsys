import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/user.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/services/group_head_service.dart';
import 'package:vms/services/host_name_service.dart';

class CustomHostName extends StatefulWidget {
  @override
  State<CustomHostName> createState() => _CustomHostNameState();
}

class _CustomHostNameState extends State<CustomHostName> {
  String hostName = "Click to select Host name";
  double opacity = 0.2;
  @override
  Widget build(BuildContext context) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: true);
    String staffName =
        context.read<AppointmentNotifier>().appointments[0].host.username;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputLabel(labelText: "Host"),
          CustomErrorLabel(
              errorText: _appointmentNotifier.allNewAppointmentErrors["host"]),
          GestureDetector(
            onTap: () async {
              var result = await showSearch(
                context: context,
                delegate: HostNameSearch(),
              );

              if (result != null) {
                print("Host here: ${result}");
                context.read<AppointmentNotifier>().addHost(result);
                setState(() {
                  hostName = context
                      .read<AppointmentNotifier>()
                      .appointments[0]
                      .host
                      .username;
                });
                context.read<AppointmentNotifier>().removeError("host");
              }
            },
            child: Container(
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                staffName == "" ? hostName : staffName,
                style: TextStyle(
                  color: staffName.isEmpty
                      ? Palette.FBN_BLUE.withOpacity(opacity)
                      : Palette.FBN_BLUE.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                  color: Palette.LAVENDAR_GREY,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HostNameSearch extends SearchDelegate<Host> {
  HostNameService get service => GetIt.I<HostNameService>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    Host host = Host(
      id: "",
      username: "",
      email: "",
    );

    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(
              context,
              host,
            );
          } else {
            query = '';
          }
        },
        icon: Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    Host host = Host(
      id: "",
      username: "",
      email: "",
    );

    return IconButton(
      onPressed: () {
        return close(
          context,
          host,
        );
      },
      icon: Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.person),
          SizedBox(
            height: 30,
          ),
          Text(
            query,
            style: TextStyle(
              color: Palette.FBN_BLUE,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<APIResponse<List<Host>>>(
      future: service.getHosts(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                color: Palette.FBN_BLUE,
              ),
            );
          default:
            return buildSuggestionsSuccess(snapshot.data?.data ?? []);
        }
      },
    );
  }

  Widget buildSuggestionsSuccess(List<Host> suggestions) {
    var suggestedHosts = suggestions.where((host) {
      final queryText = query.toLowerCase();
      final ghText = host.username.toLowerCase();
      return ghText.startsWith(queryText);
    }).toList();

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: suggestedHosts.length,
      itemBuilder: (context, index) {
        final suggestion = suggestedHosts[index];
        final queryText = suggestion.username.substring(0, query.length);
        final remainingText = suggestion.username.substring(query.length);
        return ListTile(
          tileColor: Palette.CUSTOM_WHITE,
          contentPadding: EdgeInsets.all(4),
          minVerticalPadding: 3,
          onTap: () {
            query = suggestion.username;
            close(context, suggestion);
          },
          leading: Icon(Icons.person),
          title: Container(
            padding: EdgeInsets.all(4),
            child: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
          subtitle: Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(suggestion.email),
                Text(
                  suggestion.id,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
