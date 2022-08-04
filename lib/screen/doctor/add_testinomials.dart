import 'package:cancer_free/models/testinomial.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/utils/toast.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddTestinomials extends HookWidget {
  const AddTestinomials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = useTextEditingController();
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Add Testinomials')),
        body: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            TextFormFieldWidget(controller: message, hintText: "Textinomials"),
            ButtonWidget(
                title: 'Add',
                onPressed: () {
                  DoctorProvider().addTestnomial(
                      onSuccess: () {
                        navigateBack(context: context);
                      },
                      onException: (e) {
                        toast(e, context, taskSuccess: false);
                      },
                      data: TestonomialModel(
                          did: DoctorProvider.did, messages: message.text));
                }),
            const SizedBox(height: 25)
          ],
        ));
  }
}
