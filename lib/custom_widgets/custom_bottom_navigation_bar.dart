import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final bool isGH;
  const CustomBottomNavigationBar({Key? key, required this.isGH})
      : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  late var navigationTable = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigationTable = [
      '/home',
      '/view',
      '/appointment_requests',
      '/view',
    ];
  }

  void navigateTo(int index) {
    Navigator.pushNamed(context, navigationTable[index]);
  }

  Color selectColor(int index) {
    return _selectedIndex == index
        ? Palette.CUSTOM_YELLOW
        : Palette.CUSTOM_WHITE;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Palette.CUSTOM_WHITE,
      // selectedItemColor: Palette.CUSTOM_YELLOW,
      currentIndex: _selectedIndex,
      onTap: (index) {
        print("index ${index}");
        _selectedIndex = index;
        navigateTo(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Palette.FBN_BLUE,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          label: 'Home',
          icon: ImageIcon(
            AssetImage("assets/images/navigation_home_icon.png"),
            // color: selectColor(_selectedIndex),
          ),
        ),
        new BottomNavigationBarItem(
          label: 'Folder',
          icon: ImageIcon(
            AssetImage("assets/images/navigation_folder_icon.png"),
            // color: selectColor(_selectedIndex),
          ),
        ),
        widget.isGH
            ? new BottomNavigationBarItem(
                label: 'Notification',
                icon: ImageIcon(
                  AssetImage("assets/images/navigation_approval_icon.png"),
                  // color: selectColor(_selectedIndex),
                ),
              )
            : new BottomNavigationBarItem(
                label: 'Requests',
                icon: ImageIcon(
                  AssetImage("assets/images/navigation_notification_icon.png"),
                  // color: selectColor(_selectedIndex),
                ),
              ),
        new BottomNavigationBarItem(
          label: 'Four',
          icon: Text(""),
        ),
      ],
    );
  }
}
