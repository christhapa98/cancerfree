import 'package:cancer_free/models/testinomial.dart';
import 'package:cancer_free/screen/doctor/add_testinomials.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserTestinomials extends HookWidget {
  const UserTestinomials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(title: const Text('All Testinomials')),
        body: refresh.value
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future:
                    FirebaseFirestore.instance.collection('testnomial').get(),
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
                                child: Text('No Appointments Made For You'))
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, ind) {
                                  TestonomialModel data =
                                      TestonomialModel.fromJson(
                                          snapshot.data!.docs[ind].data());
                                  return ListTile(
                                    leading: const Icon(Icons.message),
                                    title: Text(data.messages),
                                  );
                                });
                      }
                  }
                }));
  }
}
