import 'package:flutter/material.dart';
import 'package:vms/data/assets.dart';
import 'package:vms/models/asset.dart';

class AssetsNotifier with ChangeNotifier {
  List<Asset> get allassets {
    return createAssetsFromData(assets);
  }

  List<Asset> createAssetsFromData(List<dynamic> assets) {
    int count = 0;
    List<Asset> allassets = assets.map((room) {
      return new Asset(name: room, id: (++count).toString());
    }).toList();

    return allassets;
  }
}
