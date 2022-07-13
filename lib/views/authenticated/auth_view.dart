import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/views/view.dart';
import 'package:vms/views/wrapper.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _ViewState();
}

class _ViewState extends State<AuthView> {
  bool isGH = false;

  @override
  void initState() {
    super.initState();
    UserNotifier _userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    isGH = _userNotifier.userIsGH;
    print("is user GH? ${isGH}");
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      widget: View(),
      isGH: isGH,
      navbarPresent: true,
    );
  }
}
