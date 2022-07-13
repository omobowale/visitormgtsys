import 'package:flutter/cupertino.dart';
import 'package:vms/models/visitor.dart';

class GuestNotifier with ChangeNotifier {
  List<Visitor> visitors = [];

  List<Visitor> get allVisitors => [...visitors];

  void addVisitor(Visitor visitor) {
    visitors.add(visitor);
    notifyListeners();
  }

  
}
