import 'package:flutter/cupertino.dart';
import 'package:vms/data/group_heads.dart';
import 'package:vms/models/group_head.dart';

class GroupHeadsNotifier with ChangeNotifier {
  List<GroupHead> get allGroupHeads {
    return createGroupHeadsFromData(groupHeads);
  }

  List<GroupHead> createGroupHeadsFromData(List<dynamic> groupHeads) {
    int count = 0;
    List<GroupHead> allGroupHeads = groupHeads.map((groupHead) {
      return GroupHead(
        id: (++count),
        staffName: groupHead["staffName"],
        email: groupHead["email"],
        staffNo: groupHead["staffNo"],
        isActive: groupHead["ïsActive"],
      );
    }).toList();

    return allGroupHeads;
  }
}
