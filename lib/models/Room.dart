class Room {
  String name;
  int id;
  int floorId;

  Room({
    required this.name,
    required this.id,
    required this.floorId,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "[name: ${this.name}, id: ${this.id}, floorId: ${this.floorId}]";
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "id": id, "floorId": floorId};
  }

  factory Room.fromMap(Map<String, dynamic> room) {
    return new Room(
        id: room["id"], floorId: room["floorId"], name: room["name"]);
  }

  static List<Room> convertRoomMapsToRoomObjects(List<dynamic> rooms) {
    Iterable<Room> r = rooms.map((room) {
      if (room is Map<String, dynamic>) {
        return Room.fromMap(room);
      } else {
        return room;
      }
    });
    print("x : " + r.toString());
    return r.toList();
  }
}
