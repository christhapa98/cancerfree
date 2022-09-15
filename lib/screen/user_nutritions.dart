import 'package:cancer_free/models/nutritions.dart';
import 'package:cancer_free/screen/doctor/add_nutritions.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserNutritions extends HookWidget {
  const UserNutritions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                navigateTo(
                    context: context,
                    screen: const AddNutritions(),
                    state: () {
                      refresh.value = true;
                      refresh.value = false;
                    });
              },
              icon: const Icon(Icons.add))
        ], title: const Text('Nutritions')),
        body: refresh.value
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('nutritions')
                    .get(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const SizedBox(
                          height: 350,
                          width: 350,
                          child: Center(child: CircularProgressIndicator()));
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.data!.docs.isEmpty
                            ? const Center(
                                child: Text('No Nutritions added by You'))
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, ind) {
                                  NutritionsModel data =
                                      NutritionsModel.fromJson(
                                          snapshot.data!.docs[ind].data());
                                  return ListTile(
                                    leading:
                                        const Icon(Icons.fastfood_outlined),
                                    title: Text(data.type),
                                    subtitle: Text(data.nutritions),
                                  );
                                });
                      }
                  }
                }));
  }
}
