import 'package:cancer_free/models/appointment.dart';
import 'package:cancer_free/utils/toast.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdminAppointment extends HookWidget {
  const AdminAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('All Appointments')),
        body: refresh.value
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future:
                    FirebaseFirestore.instance.collection('appointment').get(),
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
                            ? const Center(child: Text('No Appointments Made'))
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, ind) {
                                  AppointmentModel data =
                                      AppointmentModel.fromJson(
                                          snapshot.data!.docs[ind].data());
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading:
                                            const Icon(Icons.calendar_month),
                                        title: Text(data.date
                                            .replaceAll("T00:00:00.000", "")),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data.reason),
                                            const SizedBox(height: 5),
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
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ButtonWidget(
                                                      title: 'Accept',
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'appointment')
                                                            .doc(snapshot.data!
                                                                .docs[ind].id)
                                                            .update(
                                                                {"status": 1})
                                                            .then((value) => {
                                                                  toast(
                                                                    'Accepted',
                                                                    context,
                                                                  ),
                                                                  refresh.value =
                                                                      true,
                                                                  refresh.value =
                                                                      false
                                                                })
                                                            .catchError((e) {
                                                              toast(e, context,
                                                                  taskSuccess:
                                                                      false);
                                                            });
                                                      }),
                                                ),
                                                const SizedBox(width: 15),
                                                Expanded(
                                                    child: SizedBox(
                                                        width: double.infinity,
                                                        height: 45,
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        Colors
                                                                            .red,
                                                                    shape:
                                                                        const RoundedRectangleBorder()),
                                                            onPressed: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'appointment')
                                                                  .doc(snapshot
                                                                      .data!
                                                                      .docs[ind]
                                                                      .id)
                                                                  .update({
                                                                    "status": 2
                                                                  })
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            toast(
                                                                              'Rejected',
                                                                              context,
                                                                            ),
                                                                            refresh.value =
                                                                                true,
                                                                            refresh.value =
                                                                                false
                                                                          })
                                                                  .catchError(
                                                                      (e) {
                                                                    toast(e,
                                                                        context,
                                                                        taskSuccess:
                                                                            false);
                                                                  });
                                                            },
                                                            child: const Text(
                                                                'Reject',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)))))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                      }
                  }
                }));
  }
}
