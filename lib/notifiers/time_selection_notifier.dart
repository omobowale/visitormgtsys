import 'package:flutter/material.dart';
import 'package:vms/data/time_selection.dart';

class TimeSelectionNotifier with ChangeNotifier {
  List<dynamic> timesList = timesSelection;

  List<dynamic> get times => [...timesList];
}
