import 'package:cancer_free/screen/admin/admin_login.dart';
import 'package:cancer_free/screen/home.dart';
import 'package:cancer_free/screen/login.dart';
import 'package:cancer_free/screen/signup.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/utils/session.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

import '../widgets/buttonsWidgets/button_widget.dart';

class WelcomePage extends HookWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkSession() async {
      var data = await SessionPreferencesServices().getUserSession();
      if (data != null) {
        AppProvider().usertype = UserType.user;
        AppProvider.userData = data;
        navigateAndRemoveUntil(context: context, screen: const Home());
      }
    }

    useEffect(() {
      checkSession();
      return null;
    }, []);
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Spacer(),
      const Text('Welcome to Cancer Care',
          style: TextStyle(
              fontSize: 37.0,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800),
          textAlign: TextAlign.center),
      const SizedBox(height: 25),
      GestureDetector(
          onTap: () {
            navigateTo(context: context, screen: const AdminLogin());
          },
          child: Lottie.asset('assets/welcome.json', width: 350)),
      const Spacer(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: ButtonWidget(
              title: 'Lets\'s Go',
              onPressed: () {
                navigateTo(context: context, screen: const Login());
              })),
      const SizedBox(height: 20),
      TextButton(
          onPressed: () {
            navigateTo(context: context, screen: const Signup());
          },
          child: const Text('Register', style: TextStyle())),
      const SizedBox(height: 20),
    ])));
  }
}
