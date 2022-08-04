import 'dart:developer';

import 'package:cancer_free/models/appointment.dart';
import 'package:cancer_free/models/doctor.dart';
import 'package:cancer_free/models/testinomial.dart';
import 'package:cancer_free/models/user.dart';
import 'package:cancer_free/utils/session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserType { admin, user, doctor }

class AppProvider {
  static UserModel? userData;
  static String uid = "";
  UserType? usertype;

  void getUserDetails(id) async {}

  userLogin({email, password, onSuccess, onException}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot = await collection.doc(value.user!.uid).get();
      if (docSnapshot.exists) {
        UserModel data = UserModel.fromJson(docSnapshot.data()!);
        userData = data;
        usertype = UserType.user;
        uid = docSnapshot.id;
        await SessionPreferencesServices().setUserSession(userSession: data);
      }
      onSuccess();
    }).catchError((e) => onException(e.toString()));
  }

  userSignup(
      {email, password, required UserModel data, onSuccess, onException}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(data.toAddJson())
          .then((v) {
        userData = data;
        usertype = UserType.user;
        uid = value.user!.uid;
        onSuccess();
      });
    }).catchError((e) {
      log(e);
      onException();
    });
  }

  addDoctor({required DoctorModel data, onSuccess, onException}) {
    FirebaseFirestore.instance
        .collection('doctors')
        .add(data.toJson())
        .then((value) => {onSuccess()})
        .catchError((e) {
      onException(e);
    });
  }

  makeAppiontment({required AppointmentModel data, onSuccess, onException}) {
    FirebaseFirestore.instance
        .collection('appointment')
        .add(data.toJson())
        .then((value) => {onSuccess()})
        .catchError((e) {
      onException(e);
    });
  }

  getDoctors() async {
    return await FirebaseFirestore.instance.collection('doctors').get();
  }
}

class DoctorProvider {
  DoctorModel? doctor;
  static String did = "";

  addTestnomial({required TestonomialModel data, onSuccess, onException}) {
    FirebaseFirestore.instance
        .collection('testnomial')
        .add(data.toJson())
        .then((value) => {onSuccess()})
        .catchError((e) {
      onException(e);
    });
  }

  getTestnomial() async {
    return await FirebaseFirestore.instance.collection('testnomial').get();
  }
}
