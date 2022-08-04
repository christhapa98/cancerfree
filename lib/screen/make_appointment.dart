import 'dart:developer';

import 'package:cancer_free/models/appointment.dart';
import 'package:cancer_free/models/doctor.dart';
import 'package:cancer_free/screen/welcome.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MakeAppointment extends HookWidget {
  const MakeAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = useTextEditingController();
    final reason = useTextEditingController();
    final selectedDoctor = useState<DoctorModel?>(null);
    final docid = useState<String>("");
    final name = useTextEditingController();

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    navigateAndRemoveUntil(
                        context: context, screen: const WelcomePage());
                  },
                  icon: const Icon(Icons.add))
            ],
            title: const Text('Book Appointments')),
        body: ListView(padding: const EdgeInsets.all(15.0), children: [
          GestureDetector(
              onTap: () async {
                DateTime? d = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050));
                if (d != null) {
                  date.text = d.toIso8601String();
                }
              },
              child: TextFormFieldWidget(
                  controller: date,
                  hintText: 'Select Date',
                  label: 'Select Date',
                  isEnabled: false)),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                        content: SizedBox(
                            height: 400,
                            width: 400,
                            child: Column(children: [
                              const Text("Select your Name",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              FutureBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  future: FirebaseFirestore.instance
                                      .collection('doctors')
                                      .get(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return const SizedBox(
                                            height: 350,
                                            width: 350,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      default:
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          return SizedBox(
                                              height: 350,
                                              width: 350,
                                              child: snapshot.data!.docs.isEmpty
                                                  ? const Center(
                                                      child: Text('No Doctors'))
                                                  : ListView.builder(
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder: (_, ind) {
                                                        DoctorModel data =
                                                            DoctorModel.fromJson(
                                                                snapshot.data!
                                                                    .docs[ind]
                                                                    .data());
                                                        return ListTile(
                                                            title:
                                                                Text(data.name),
                                                            onTap: () {
                                                              selectedDoctor
                                                                  .value = data;
                                                              docid.value =
                                                                  snapshot
                                                                      .data!
                                                                      .docs[ind]
                                                                      .id;
                                                              name.text =
                                                                  data.name;
                                                              navigateBack(
                                                                  context:
                                                                      context);
                                                            });
                                                      }));
                                        }
                                    }
                                  })
                            ])));
                  });
            },
            child: TextFormFieldWidget(
                label: 'Select Doctor',
                isEnabled: false,
                controller: name,
                hintText: 'Select doctor'),
          ),
          TextFormFieldWidget(
              label: 'Appointment Reason',
              controller: reason,
              hintText: 'Reason'),
          ButtonWidget(
              title: 'Add',
              onPressed: () {
                AppProvider().makeAppiontment(
                    data: AppointmentModel(
                        date: date.text,
                        did: docid.value,
                        reason: reason.text,
                        uid: AppProvider.uid,
                        status: 0),
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
