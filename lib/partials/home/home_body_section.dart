import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vms/custom_widgets/custom_module_card.dart';
import 'package:vms/data/modules.dart';
import 'package:vms/views/view.dart';

class HomeBodySection extends StatefulWidget {
  const HomeBodySection({Key? key}) : super(key: key);

  @override
  State<HomeBodySection> createState() => _HomeBodySectionState();
}

class _HomeBodySectionState extends State<HomeBodySection> {
  @override
  Widget build(BuildContext context) {
    print("home");
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        childAspectRatio: 1.5,
        controller: new ScrollController(keepScrollOffset: false),
        children: [
          ...modules.map((module) {
            return ModuleCard(
                moduleId: module.id,
                moduleName: module.moduleName,
                moduleIconPath: module.moduleIconPath,
                onTap: () {
                  Navigator.pushNamed(context, '/view');
                });
          }).toList()
        ],
      ),
    );
  }
}
