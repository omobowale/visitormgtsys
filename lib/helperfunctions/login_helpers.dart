import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_alert_dialog_box.dart';
import 'package:vms/models/login.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/services/login_service.dart';

void logUserIn(
  String username,
  String password,
  bool isLoading,
  String usernameError,
  String passwordError,
  Color errorColor,
  Color usernameErrorColor,
  Color passwordErrorColor,
  BuildContext context,
  LoginService service,
) {
  var loginDetails = LoginDetails(username, password);
  service.login(loginDetails).then(
    (value) {
      if (value.serverError == true) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialogBox(
              textTitle: "Error",
              textContent: "${value.errorMessage}",
              color: Colors.red,
              redirectLocation: '/login',
              function: () {},
            );
          },
        );
        return;
      }
      if (value.data != null) {
        var newUser = value.data ?? null;

        context.read<LoginLogoutNotifier>().logUserIn(newUser!).then(
          (value) {
            print(context.read<LoginLogoutNotifier>().isLoggedIn);
            context.read<UserNotifier>().getAndSetUserRoles().then(
              (value) {
                print("value from login: ${value}");
                Navigator.pushNamed(context, '/home');
              },
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialogBox(
              color: Colors.red,
              textTitle: "Error",
              redirectLocation: '/login',
              textContent: "${value.errorMessage}",
              function: () {},
            );
          },
        );
      }
    },
  );
}
