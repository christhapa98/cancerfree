import 'dart:developer';

import 'package:cancer_free/models/doctor.dart';
import 'package:cancer_free/screen/login.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddDoctor extends HookWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phoneNo = useTextEditingController();
    final name = useTextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Doctor'),
        ),
        body: ListView(padding: const EdgeInsets.all(15.0), children: [
          const SizedBox(height: 25),
          TextFormFieldWidget(controller: name, hintText: 'Name'),
          TextFormFieldWidget(
              controller: phoneNo,
              inputType: TextInputType.phone,
              hintText: 'Phone Number'),
          const SizedBox(height: 25),
          ButtonWidget(
              title: 'Add',
              onPressed: () {
                AppProvider().addDoctor(
                    data: DoctorModel(
                        name: name.text, phoneNo: phoneNo.text, shift: 0),
                    onSuccess: () {
                      navigateBack(context: context);
                    },
                    onException: (e) {
                      log(e.toString());
                    });
              }),
          const SizedBox(height: 25)
        ]));
  }
}
