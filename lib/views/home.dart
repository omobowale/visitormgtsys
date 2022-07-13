import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vms/partials/home/home_body_section.dart';
import 'package:vms/partials/home/home_menu_section.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff174574),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 20,
              bottom: 40,
            ),
            child: HomeMenuSection(),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
              top: 20,
              bottom: 40,
            ),
            child: HomeBodySection(),
          ),
        ],
      ),
    );
  }
}
