import 'package:flutter/material.dart';

class ModuleCard extends StatefulWidget {
  final String moduleName;
  final String moduleId;
  final String moduleIconPath;
  final Function onTap;

  ModuleCard({
    Key? key,
    required this.moduleId,
    required this.moduleName,
    required this.moduleIconPath,
    required this.onTap,
  });

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        child: Card(
          margin: EdgeInsets.all(10),
          color: Colors.white.withOpacity(0.05),
          shadowColor: Colors.blue,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ImageIcon(
                    AssetImage(widget.moduleIconPath),
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.moduleName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
