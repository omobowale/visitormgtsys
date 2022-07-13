import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_bottom_navigation_bar.dart';
import 'package:vms/custom_widgets/custom_floating_action_button.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/views/login.dart';

class Wrapper extends StatelessWidget {
  Widget widget;
  bool navbarPresent;
  bool isGH;
  Wrapper(
      {Key? key,
      required this.widget,
      this.navbarPresent = false,
      this.isGH = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.read<LoginLogoutNotifier>().isLoggedIn;
    print("is group head ${isGH}");
    return !isLoggedIn
        ? Login()
        : Scaffold(
            body: widget,
            bottomNavigationBar: navbarPresent
                ? CustomBottomNavigationBar(
                    isGH: isGH,
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton:
                navbarPresent ? CustomFloatingActionButton() : Container(),
          );
  }
}
