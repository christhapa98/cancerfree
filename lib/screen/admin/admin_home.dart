import 'package:cancer_free/screen/admin/admin_doctor.dart';
import 'package:cancer_free/screen/admin/patients.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdminHome extends HookWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('CancerFree Admin')),
        body: ListView(children: [
          ListTile(
              leading: const Icon(Icons.health_and_safety),
              title: const Text('Doctors'),
              onTap: () {
                navigateTo(context: context, screen: const AdminDoctors());
              }),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Patients'),
              onTap: () {
                navigateTo(context: context, screen: const Patients());
              }),
          const ListTile(leading: Icon(Icons.list), title: Text('Appointments'))
        ]));
  }
}
