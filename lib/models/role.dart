import 'package:vms/models/group_head.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class Role {
  String id;
  String name;

  Role({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }

    return item;
  }
}
