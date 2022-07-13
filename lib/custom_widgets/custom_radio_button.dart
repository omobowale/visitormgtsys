import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class CustomRadioButton extends StatelessWidget {
  final String labelText;
  final bool isAvailable;
  Function isClicked;
  final String checkText;

  CustomRadioButton(
      {Key? key,
      required this.isClicked,
      required this.checkText,
      required this.labelText,
      required this.isAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isClicked(labelText);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              boxShadow: !((checkText == labelText))
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
                color: (checkText == labelText)
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
                    color: ((checkText != labelText) && !isAvailable)
                        ? Palette.LAVENDAR_GREY
                        : Palette.FBN_BLUE,
                  ),
                ),
                Container(
                  child: checkText == labelText
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
