import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';

class SummaryFooterTimestamp extends StatelessWidget {
  String? stampText = "";

  String? buttonText;
  SummaryFooterTimestamp({Key? key, this.stampText, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            stampText != null
                ? Text(
                    stampText ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                : Text(""),
          ],
        ),
        buttonText != null
            ? CustomTextWithBackground(
                text: buttonText ?? "",
                textColor: Palette.FBN_BLUE,
                backgroundColor: Palette.LAVENDAR_GREY,
                fn: () {},
              )
            : Container(),
      ],
    );
  }
}
