import 'dart:developer';

import 'package:cancer_free/models/user.dart';
import 'package:cancer_free/screen/home.dart';
import 'package:cancer_free/screen/login.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Signup extends HookWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phoneNo = useTextEditingController();
    final password = useTextEditingController();
    final email = useTextEditingController();
    final name = useTextEditingController();
    final showHidePassword = useState<bool>(false);
    final loading = useState<bool>(false);

    return Scaffold(
        appBar: AppBar(),
        body: ListView(padding: const EdgeInsets.all(15.0), children: [
          const Text('Register',
              style: TextStyle(
                  fontSize: 37.0,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 25),
          TextFormFieldWidget(controller: name, hintText: 'Name'),
          TextFormFieldWidget(
              controller: email,
              inputType: TextInputType.emailAddress,
              hintText: 'Email'),
          TextFormFieldWidget(
              controller: phoneNo,
              inputType: TextInputType.phone,
              hintText: 'Phone Number'),
          TextFormFieldWidget(
              inputType: TextInputType.visiblePassword,
              controller: password,
              passwordVisible: showHidePassword.value,
              suffixIcon: IconButton(
                  onPressed: () =>
                      showHidePassword.value = !showHidePassword.value,
                  icon: const Icon(Icons.remove_red_eye)),
              hintText: 'Password'),
          const SizedBox(height: 25),
          loading.value
              ? const Center(child: CircularProgressIndicator())
              : ButtonWidget(
                  title: 'Register',
                  onPressed: () async {
                    loading.value = true;
                    AppProvider().userSignup(
                        email: email.text,
                        password: password.text,
                        data: UserModel(
                            name: name.text,
                            usertype: 0,
                            phoneNo: phoneNo.text,
                            email: email.text),
                        onException: (e) {
                          log(e.toString());
                        },
                        onSuccess: () {
                          loading.value = false;
                          navigateAndRemoveUntil(
                              context: context, screen: const Home());
                        });
                  }),
          const SizedBox(height: 25),
          TextButton(
              onPressed: () {
                navigateTo(context: context, screen: const Login());
              },
              child: const Text('Already have an Account? Login now',
                  style: TextStyle(color: Colors.black)))
        ]));
  }
}
