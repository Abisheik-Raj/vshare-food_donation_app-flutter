import "package:flutter/material.dart";
import "package:vshare/pages/login_page.dart";
import "package:vshare/pages/register_page.dart";

class LoginOrRegisterPage extends StatefulWidget {
  LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void onTap() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage == true) {
      return LoginPage(
        onTap: onTap,
      );
    } else {
      return RegisterPage(
        onTap: onTap,
      );
    }
  }
}
