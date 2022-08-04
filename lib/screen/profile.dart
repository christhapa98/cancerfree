import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserProfile extends HookWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false, title: const Text('Profile')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(children: [
            const SizedBox(height: 25),
            const Icon(Icons.person, size: 55),
            const SizedBox(height: 25),
            Text(AppProvider.userData!.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(AppProvider.userData!.email),
            const SizedBox(height: 10),
            Text(AppProvider.userData!.phoneNo)
          ])),
        ));
  }
}
