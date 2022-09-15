import 'package:cancer_free/screen/home.dart';
import 'package:cancer_free/screen/signup.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/utils/toast.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Login extends HookWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final showHidePassword = useState<bool>(true);
    final loading = useState<bool>(false);

    return Scaffold(
        appBar: AppBar(),
        body: ListView(padding: const EdgeInsets.all(15.0), children: [
          const Text('Login',
              style: TextStyle(
                  fontSize: 37.0,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 25),
          TextFormFieldWidget(
              controller: email,
              inputType: TextInputType.emailAddress,
              hintText: 'Email'),
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
                  title: 'Login',
                  onPressed: () {
                    loading.value = true;
                    AppProvider().userLogin(
                        email: email.text,
                        password: password.text,
                        onException: (e) {
                          loading.value = false;
                          toast(e, context, taskSuccess: false);
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
                navigateTo(context: context, screen: const Signup());
              },
              child: const Text('Dont have an Account? Register now',
                  style: TextStyle(color: Colors.black)))
        ]));
  }
}
