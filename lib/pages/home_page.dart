import 'package:beaconstac_app/services/auth_service.dart';

import 'package:beaconstac_app/pages/login_page.dart';
import 'package:beaconstac_app/pages/profile_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String? errorMessage;
  String? name;
  String? picture;
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beaconstac app"),
      ),
      body: Center(
        child: isBusy
            ? const CircularProgressIndicator()
            : isLoggedIn
                ? Profile(
                    logout,
                    name == null ? "" : name as String,
                    picture == null ? "" : picture as String,
                    email == null ? "" : email as String)
                : Login(loginAction,
                    errorMessage == null ? "" : errorMessage as String),
      ),
    );
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  Future<void> loginAction() async {
    setLoadingState();
    final message = await AuthService.instance.login();
    if (message == 'Success') {
      setSuccessAuthState();
    } else {
      setState(() {
        isBusy = false;
        errorMessage = message;
      });
    }
  }

  Future<void> logout() async {
    setLoadingState();
    await AuthService.instance.logout();
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  setLoadingState() {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });
  }

  setSuccessAuthState() async {
    setState(() {
      isBusy = false;
      isLoggedIn = true;
      name = AuthService.instance.idToken['name'];
      email = AuthService.instance.idToken['email'];
      picture = AuthService.instance.idToken['picture'];
    });
  }

  initAction() async {
    setLoadingState();
    final bool isAuth = await AuthService.instance.init();
    if (isAuth) {
      setSuccessAuthState();
    } else {
      setState(() {
        isBusy = false;
      });
    }
  }
}
