import 'package:flutter/material.dart';
import 'package:vms/models/host.dart';

class StaffDetails extends StatelessWidget {
  final Host host;
  final String staffImagePath;

  const StaffDetails({
    Key? key,
    required this.staffImagePath,
    required this.host,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("host ${host}");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.56),
              child: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      staffImagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  radius: 13),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Container(
            child: Text(
              host.username,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
