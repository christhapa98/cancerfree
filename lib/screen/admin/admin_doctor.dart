import 'package:cancer_free/models/doctor.dart';
import 'package:cancer_free/screen/admin/add_doctor.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdminDoctors extends HookWidget {
  const AdminDoctors({Key? key}) : super(key: key);

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
        ], title: const Text('Doctors')),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection('doctors').get(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return snapshot.data!.docs.isEmpty
                        ? const Center(child: Text('No Doctors'))
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, ind) {
                              DoctorModel data = DoctorModel.fromJson(
                                  snapshot.data!.docs[ind].data());
                              return ListTile(
                                  title: Text(data.name),
                                  subtitle: Text(data.phoneNo),
                                  trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Shift",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        Text(data.shift == 0 ? "Day" : "Night")
                                      ]));
                            });
                  }
              }
            }));
  }
}
