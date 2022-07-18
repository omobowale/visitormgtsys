import 'package:flutter/cupertino.dart';
import 'package:vms/data/rooms.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/user.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';

class LoadingNotifier with ChangeNotifier {
  bool _loading = false;

  setLoading(bool isLoading) {
    _loading = isLoading;
  }

  get getLoading {
    return _loading;
  }
}
