import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_single_line_button.dart';

class InformationDisplay extends StatelessWidget {
  final String infoImagePath;
  final String messageTitle;
  final String messageBody;
  final String buttonText;
  final Function buttonFunction;
  const InformationDisplay({
    Key? key,
    required this.infoImagePath,
    required this.messageTitle,
    required this.messageBody,
    required this.buttonText,
    required this.buttonFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image(image: AssetImage(infoImagePath)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        messageTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Center(
                        child: Text(
                          messageBody,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
            ),
            child: CustomSingleLineButton(
              text: buttonText,
              backgroundColor: Palette.FBN_BLUE,
              textColor: Palette.CUSTOM_WHITE,
              fn: () {
                buttonFunction();
              },
            ),
          )
        ],
      ),
    );
  }
}
