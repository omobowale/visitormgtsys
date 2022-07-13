import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';

class SummaryFooterTimestampWithArray extends StatelessWidget {
  List<dynamic> stampTextsList;
  final String? buttonText;
  SummaryFooterTimestampWithArray(
      {Key? key, this.buttonText, required this.stampTextsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...stampTextsList.map((e) {
              return Text(
                e.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              );
            }).toList(),
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
