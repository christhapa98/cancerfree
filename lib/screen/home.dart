import 'package:cancer_free/models/doctor.dart';
import 'package:cancer_free/screen/appointment.dart';
import 'package:cancer_free/screen/bmi.dart';
import 'package:cancer_free/screen/my_bills.dart';
import 'package:cancer_free/screen/profile.dart';
import 'package:cancer_free/screen/testinomial_user.dart';
import 'package:cancer_free/screen/user_nutritions.dart';
import 'package:cancer_free/screen/welcome.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/utils/session.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: 1,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black26,
            items: [
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        navigateTo(
                            screen: const UserTestinomials(), context: context);
                      },
                      child: const Icon(Icons.message)),
                  label: 'Testinomials'),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {}, child: const Icon(Icons.home)),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        navigateTo(
                            screen: const UserAppointment(), context: context);
                      },
                      child: const Icon(Icons.book)),
                  label: 'Appointments'),
            ]),
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                navigateTo(screen: const UserProfile(), context: context);
              },
              icon: const Icon(Icons.person)),
          IconButton(
              onPressed: () async {
                await SessionPreferencesServices().clearUserSession();
                AppProvider.userData = null;
                navigateAndRemoveUntil(
                    context: context, screen: const WelcomePage());
              },
              icon: const Icon(Icons.logout)),
        ], automaticallyImplyLeading: false, title: const Text('Cancer Care')),
        body: ListView(padding: const EdgeInsets.all(15.0), children: [
          const SizedBox(height: 20),
          const Banners(),
          const SizedBox(height: 20),
          const Text('Calculate Your BMI',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          GestureDetector(
              onTap: () {
                navigateTo(
                    screen: const BmiPage(), context: context, state: () {});
              },
              child: Lottie.asset("assets/bmi.json", height: 150, width: 200)),
          const SizedBox(height: 20),
          ListTile(
              onTap: () {
                navigateTo(screen: const UserHistories(), context: context);
              },
              leading: const Icon(Icons.history),
              title: const Text('Manage your histories',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              trailing: const Icon(Icons.chevron_right)),
          ListTile(
              onTap: () {
                navigateTo(screen: const UserNutritions(), context: context);
              },
              leading: const Icon(Icons.fastfood_sharp),
              title: const Text('Nutritions',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              trailing: const Icon(Icons.chevron_right)),
          const SizedBox(height: 20),
          const Text('Our Doctors',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const Doctors(),
        ]));
  }
}

class Doctors extends StatelessWidget {
  const Doctors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: 500,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, ind) {
                              DoctorModel data = DoctorModel.fromJson(
                                  snapshot.data!.docs[ind].data());
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        const Icon(Icons.health_and_safety,
                                            size: 35),
                                        const SizedBox(height: 10),
                                        Text(data.name.toUpperCase()),
                                        const SizedBox(height: 5),
                                        Text(data.phoneNo),
                                        const SizedBox(height: 5),
                                        Text(data.shift == 0 ? "Day" : "Night")
                                      ]));
                            });
                  }
              }
            }));
  }
}

class Banners extends StatelessWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: CarouselSlider(
            items: [
              'https://cdn.geckoandfly.com/wp-content/uploads/2018/10/cancer-quotes-01.jpg',
              'https://www.wishesmsg.com/wp-content/uploads/Encouraging-Words-For-Cancer-Patients-1.jpg',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_DfgKGM_qP3AXR87dmkHnNr6P9HujOUARqA&usqp=CAU'
            ]
                .map((e) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(e)))))
                .toList(),
            options: CarouselOptions(enlargeCenterPage: true, autoPlay: true)));
  }
}
