import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Palette.FBN_BLUE,
        ),
      ),
    );
  }
}
