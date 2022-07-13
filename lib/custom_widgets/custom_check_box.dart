import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class CustomCheckBox extends StatelessWidget {
  final Function isClicked;
  final String id;
  final String labelText;
  final bool checked;
  final bool isAvailable;
  List<dynamic> checkList;

  CustomCheckBox({
    Key? key,
    required this.labelText,
    required this.id,
    required this.isClicked,
    required this.checkList,
    required this.checked,
    required this.isAvailable,
  }) : super(key: key);

  bool isChecked(List<dynamic> rooms, String label) {
    var r = rooms.firstWhere(
      (r) => r.name == label,
      orElse: () => null,
    );

    if (r != null) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        isClicked(id);
        print(checkList.toString());
      }),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              boxShadow: checkList.contains((_) => _.name == labelText)
                  ? [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  : [],
              border: Border.all(
                color: isChecked(checkList, labelText)
                    ? Palette.FBN_BLUE
                    : Palette.LAVENDAR_GREY,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelText,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color:
                          (!(isChecked(checkList, labelText)) && !isAvailable)
                              ? Palette.LAVENDAR_GREY
                              : Palette.FBN_BLUE),
                ),
                Container(
                  child: isChecked(checkList, labelText)
                      ? Icon(
                          Icons.check_circle,
                          color: Palette.FBN_BLUE,
                        )
                      : (isAvailable
                          ? Icon(
                              Icons.circle_outlined,
                              color: Palette.LAVENDAR_GREY,
                            )
                          : Container(
                              child: Text(
                                "Unavailable".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 119, 139, 158)
                                      .withOpacity(0.6),
                                ),
                              ),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Palette.CUSTOM_WHITE,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Palette.LAVENDAR_GREY),
                            )),
                  // color: Palette.FBN_BLUE,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
