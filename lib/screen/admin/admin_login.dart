import 'dart:developer';

import 'package:cancer_free/models/doctor.dart';
import 'package:cancer_free/screen/admin/admin_home.dart';
import 'package:cancer_free/screen/doctor/doctor_home.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/utils/toast.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdminLogin extends HookWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                bottom: const TabBar(tabs: [
              Tab(child: Text('Admin', style: TextStyle(color: Colors.black))),
              Tab(child: Text('Doctor', style: TextStyle(color: Colors.black)))
            ])),
            body: const TabBarView(
                children: [AdminLoginForm(), DoctorLoginForm()])));
  }
}

class AdminLoginForm extends HookWidget {
  const AdminLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController(text: "admin@cancerfree");
    final password = useTextEditingController(text: "password@cancerfree");
    final showHidePassword = useState<bool>(false);
    return ListView(padding: const EdgeInsets.all(15.0), children: [
      const Text('Admin Login',
          style: TextStyle(
              fontSize: 37.0,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800)),
      const SizedBox(height: 25),
      TextFormFieldWidget(
          controller: email,
          inputType: TextInputType.emailAddress,
          hintText: 'Email'),
      TextFormFieldWidget(
          inputType: TextInputType.visiblePassword,
          controller: password,
          passwordVisible: showHidePassword.value,
          suffixIcon: IconButton(
              onPressed: () => showHidePassword.value = !showHidePassword.value,
              icon: const Icon(Icons.remove_red_eye)),
          hintText: 'Password'),
      const SizedBox(height: 25),
      ButtonWidget(
          title: 'Login',
          onPressed: () {
            if (email.text == "admin@cancerfree" &&
                password.text == "password@cancerfree") {
              AppProvider().usertype = UserType.admin;
              navigateTo(context: context, screen: const AdminHome());
            }
          }),
      const SizedBox(height: 25),
    ]);
  }
}

class DoctorLoginForm extends HookWidget {
  const DoctorLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController();
    final did = useState<String>("");
    final password = useTextEditingController(text: "989524560");
    final showHidePassword = useState<bool>(false);
    final selectedDoctor = useState<DoctorModel?>(null);

    void doctorLogin() async {
      if (selectedDoctor.value!.phoneNo == password.text) {
        DoctorProvider.did = did.value;
        navigateAndRemoveUntil(context: context, screen: const DoctorHome());
      }
    }

    return ListView(padding: const EdgeInsets.all(15.0), children: [
      const Text('Doctor Login',
          style: TextStyle(
              fontSize: 37.0,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800)),
      const SizedBox(height: 25),
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
                          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                                      return Text('Error: ${snapshot.error}');
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
                                                            snapshot
                                                                .data!.docs[ind]
                                                                .data());
                                                    return ListTile(
                                                        title: Text(data.name),
                                                        onTap: () {
                                                          selectedDoctor.value =
                                                              data;
                                                          did.value = snapshot
                                                              .data!
                                                              .docs[ind]
                                                              .id;
                                                          name.text = data.name;
                                                          navigateBack(
                                                              context: context);
                                                        });
                                                  }));
                                    }
                                }
                              })
                        ])));
              });
        },
        child: TextFormFieldWidget(
            isEnabled: false, controller: name, hintText: 'Select Your Name'),
      ),
      TextFormFieldWidget(
          inputType: TextInputType.visiblePassword,
          controller: password,
          passwordVisible: showHidePassword.value,
          suffixIcon: IconButton(
              onPressed: () => showHidePassword.value = !showHidePassword.value,
              icon: const Icon(Icons.remove_red_eye)),
          hintText: 'Password'),
      const SizedBox(height: 25),
      ButtonWidget(
          title: 'Login',
          onPressed: () {
            if (password.text == selectedDoctor.value!.phoneNo) {
              doctorLogin();
            } else {
              toast('Password Doesnot Match', context, taskSuccess: false);
              log(selectedDoctor.value!.phoneNo.toString());
            }
          }),
      const SizedBox(height: 25)
    ]);
  }
}
