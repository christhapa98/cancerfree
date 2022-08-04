import 'package:cancer_free/screen/welcome.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class More extends HookWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    navigateAndRemoveUntil(
                        context: context, screen: const WelcomePage());
                  },
                  icon: const Icon(Icons.logout))
            ],
            title: const Text('CancerFree Doctor')),
        body: ListView(children: const []));
  }
}
