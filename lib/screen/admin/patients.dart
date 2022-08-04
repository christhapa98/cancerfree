import 'package:cancer_free/models/user.dart';
import 'package:cancer_free/screen/admin/add_doctor.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Patients extends HookWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                navigateTo(
                    context: context,
                    screen: const AddDoctor(),
                    state: () {
                      refresh.value = true;
                    });
              },
              icon: const Icon(Icons.add))
        ], title: const Text('Patients')),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection('users').get(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return snapshot.data!.docs.isEmpty
                        ? const Center(child: Text('No Patients'))
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, ind) {
                              UserModel data = UserModel.fromJson(
                                  snapshot.data!.docs[ind].data());
                                  print(data.toAddJson());
                              return ListTile(
                                  title: Text(data.name),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data.phoneNo),
                                      Text(data.email),
                                      Text(data.email),
                                      ButtonWidget(
                                          title: data.admission == false
                                              ? 'Admit'
                                              : 'Discharge',
                                          onPressed: () {})
                                    ],
                                  ));
                            });
                  }
              }
            }));
  }
}
