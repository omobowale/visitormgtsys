import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_tile.dart';

class Guests extends StatelessWidget {
  final List<dynamic> guests;
  const Guests({Key? key, required this.guests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("guests : $guests");
    return GestureDetector(
      onTap: () {
        if (guests.length < 1) {
          return;
        }
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              title: Text(
                "Visitors details",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              content: Container(
                constraints: BoxConstraints(maxHeight: double.infinity),
                width: MediaQuery.of(context).size.width - 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...guests
                        .map(
                          (e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTile(
                                title: "${e.firstName} ${e.lastName}",
                                content: "${e.email}",
                                subcontent1: "${e.phoneNumber}",
                                subcontent2: "${e.address}",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          children: [
            Container(
              child: Icon(Icons.people),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: Text(
                "${guests.length} ${guests.length > 1 ? "Guests" : "Guest"}",
              ),
            ),
            guests.length > 0
                ? Container(
                    child: Icon(
                      Icons.arrow_right,
                      color: Palette.FBN_BLUE,
                      size: 28,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
