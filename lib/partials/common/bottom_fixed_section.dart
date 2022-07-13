import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class BottomFixedSection extends StatelessWidget {
  final String leftText;
  final String rightText;
  Function fnOne, fnTwo;

  BottomFixedSection({
    Key? key,
    required this.leftText,
    required this.rightText,
    required this.fnOne,
    required this.fnTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                fnOne();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                child: Text(
                  leftText,
                  style: TextStyle(
                    color: Palette.FBN_BLUE,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 59, 101, 0.05),
                  border: Border.all(
                    color: Color.fromRGBO(0, 59, 101, 0.05),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                fnTwo();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                child: Text(
                  rightText,
                  style: TextStyle(
                    color: Palette.CUSTOM_WHITE,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Palette.FBN_BLUE,
                  border: Border.all(
                    color: Palette.FBN_BLUE,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
