import 'package:cancer_free/screen/doctor/add_testinomials.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorTestinomials extends HookWidget {
  const DoctorTestinomials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                navigateTo(
                    context: context,
                    screen: const AddTestinomials(),
                    state: () {
                      refresh.value = true;
                      refresh.value = false;
                    });
              },
              icon: const Icon(Icons.add))
        ], automaticallyImplyLeading: false, title: const Text('Testinomials')),
        body: refresh.value
            ? const Center(child: CircularProgressIndicator())
            : Container());
  }
}
