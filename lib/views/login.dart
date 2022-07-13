import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/constants/index.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_single_line_button.dart';
import 'package:vms/helperfunctions/login_helpers.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/user.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/services/login_service.dart';
import 'package:vms/views/authenticated/auth_home.dart';
import 'package:vms/partials/login/login_logo_section.dart';
import 'package:vms/partials/login/login_welcome_section.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late APIResponse<User> user;
  LoginService get service => GetIt.I<LoginService>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool buttonDeactivated = false;
  String usernameError = "";
  String passwordError = "";
  Color defaultColor = Colors.grey;
  Color errorColor = Colors.red;
  late Color usernameErrorColor;
  late Color passwordErrorColor;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameErrorColor = defaultColor;
    passwordErrorColor = defaultColor;
  }

  void reActivateButtonAfterSomeTime() {
    Future.delayed(const Duration(milliseconds: DELAY), () {
      setState(() {
        buttonDeactivated = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context);
    bool isLoggedIn = _loginLogoutNotifier.isLoggedIn;
    return isLoggedIn
        ? AuthHome()
        : Scaffold(
            appBar: AppBar(
              actions: null,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white.withOpacity(0.1),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoginLogoSection(),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoginWelcomeSection(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  child: Material(
                                    elevation: 0.5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      onChanged: ((value) {
                                        setState(() {
                                          usernameErrorColor = defaultColor;
                                        });
                                      }),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.07),
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.07),
                                            width: 2,
                                          ),
                                        ),
                                        labelText: usernameError == ""
                                            ? 'Username'
                                            : usernameError,
                                        labelStyle: TextStyle(
                                          color: usernameErrorColor,
                                        ),
                                        hintText: "Enter Username",
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Material(
                                    elevation: 0.5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      onChanged: ((value) {
                                        setState(() {
                                          passwordErrorColor = defaultColor;
                                        });
                                      }),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      controller: passwordController,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.07),
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.07),
                                            width: 2,
                                          ),
                                        ),
                                        labelText: passwordError == ""
                                            ? 'Password'
                                            : passwordError,
                                        labelStyle: TextStyle(
                                          color: passwordErrorColor,
                                        ),
                                        hintText: 'Enter Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                                          onPressed: () {
                                            setState(
                                                () => _isObscure = !_isObscure);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          CustomSingleLineButton(
                            isLoading: isLoading,
                            text: "Login",
                            backgroundColor: Palette.FBN_BLUE,
                            textColor: Palette.CUSTOM_WHITE,
                            fn: () async {
                              if (!buttonDeactivated) {
                                print("Button activated");
                                if (usernameController.text == "") {
                                  setState(
                                    () {
                                      usernameError = "Please enter username";
                                      usernameErrorColor = Colors.red;
                                    },
                                  );
                                } else {
                                  setState(
                                    () {
                                      usernameError = "";
                                    },
                                  );
                                }
                                if (passwordController.text == "") {
                                  setState(
                                    () {
                                      passwordError = "Please enter password";
                                      passwordErrorColor = Colors.red;
                                    },
                                  );
                                } else {
                                  setState(
                                    () {
                                      passwordError = "";
                                    },
                                  );
                                }
                                if (passwordError == "" &&
                                    usernameError == "") {
                                  setState(
                                    () {
                                      isLoading = true;
                                      buttonDeactivated = true;
                                    },
                                  );

                                  reActivateButtonAfterSomeTime();

                                  logUserIn(
                                    usernameController.text,
                                    passwordController.text,
                                    isLoading,
                                    usernameError,
                                    passwordError,
                                    errorColor,
                                    usernameErrorColor,
                                    passwordErrorColor,
                                    context,
                                    service,
                                  );
                                }
                              } else {
                                print("Button deactivated");
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
