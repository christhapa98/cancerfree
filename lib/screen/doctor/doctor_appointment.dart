import 'package:cancer_free/models/appointment.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorAppoinement extends HookWidget {
  const DoctorAppoinement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Appointments')),
        body: refresh.value
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('appointment')
                    .where('did', isEqualTo: DoctorProvider.did)
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
                                child: Text('No Appointments Made For You'))
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, ind) {
                                  AppointmentModel data =
                                      AppointmentModel.fromJson(
                                          snapshot.data!.docs[ind].data());
                                  return ListTile(
                                    leading: const Icon(Icons.calendar_month),
                                    title: Text(data.date
                                        .replaceAll("T00:00:00.000", "")),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.reason),
                                        if (data.status == 0)
                                          const Text("Pending",
                                              style: TextStyle(
                                                  color: Colors.orange)),
                                        if (data.status == 1)
                                          const Text("Acepted",
                                              style: TextStyle(
                                                  color: Colors.green)),
                                        if (data.status == 2)
                                          const Text("Rejected",
                                              style:
                                                  TextStyle(color: Colors.red))
                                      ],
                                    ),
                                  );
                                });
                      }
                  }
                }));
  }
}
