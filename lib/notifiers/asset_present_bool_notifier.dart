import 'package:flutter/cupertino.dart';
import 'package:vms/data/asset_present_bools.dart';
import 'package:vms/data/visitor_types.dart';
import 'package:vms/models/asset_present_bool.dart';
import 'package:vms/models/visitor_type.dart';

class AssetPresentBoolNotifier with ChangeNotifier {
  List<AssetPresentBool> get allAssetPresentBools {
    return createAssetPresentBoolsFromData(assetPresentBools);
  }

  bool currentlySelectedAssetPresentBool = false;

  

  void addCurrentlySelectedAssetPresentBool(bool bool) {
    currentlySelectedAssetPresentBool = bool;
    notifyListeners();
  }

  List<AssetPresentBool> createAssetPresentBoolsFromData(
      List<dynamic> assetPresentBools) {
    int count = 0;
    List<AssetPresentBool> allAssetPresentBools =
        assetPresentBools.map((assetPresentBool) {
      return AssetPresentBool(
          id: (++count).toString(),
          isAssetPresentBool: assetPresentBool["value"],
          isAssetPresent: assetPresentBool["text"]);
    }).toList();

    return allAssetPresentBools;
  }
}
