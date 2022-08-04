import 'package:cancer_free/screen/admin/admin_doctor.dart';
import 'package:cancer_free/screen/admin/patients.dart';
import 'package:cancer_free/screen/doctor/doctor_appointment.dart';
import 'package:cancer_free/screen/doctor/doctor_testinomials.dart';
import 'package:cancer_free/screen/welcome.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorHome extends HookWidget {
  const DoctorHome({Key? key}) : super(key: key);

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
        body: ListView(children: [
          ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Testonomials'),
              onTap: () {
                navigateTo(
                    context: context, screen: const DoctorTestinomials());
              }),
          ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Appointments'),
              onTap: () {
                navigateTo(context: context, screen: const DoctorAppoinement());
              }),
        ]));
  }
}
