import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vms/data/purposes_of_visit.dart';

class PurposeNotifier with ChangeNotifier {
  List<dynamic> purposesList = purposesOfVisit;

  List<dynamic> get purposes => [...purposesList];
}
