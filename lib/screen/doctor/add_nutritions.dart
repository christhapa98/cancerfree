import 'package:cancer_free/models/nutritions.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/utils/toast.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddNutritions extends HookWidget {
  const AddNutritions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type = useTextEditingController();
    final nutritions = useTextEditingController();

    return Scaffold(
        appBar: AppBar(title: const Text('Add Nutritions')),
        body: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            TextFormFieldWidget(controller: type, hintText: "Cancer Type"),
            TextFormFieldWidget(
                maxLines: 5, controller: nutritions, hintText: "Nutritions"),
            ButtonWidget(
                title: 'Add',
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('nutritions')
                      .add(NutritionsModel(
                              type: type.text,
                              did: DoctorProvider.did,
                              nutritions: nutritions.text)
                          .toJson())
                      .then((value) => {
                            toast('Success', context, taskSuccess: true),
                            navigateBack(context: context)
                          })
                      .catchError((e) {
                    toast('Error', context, taskSuccess: true);
                  });
                }),
            const SizedBox(height: 25)
          ],
        ));
  }
}
