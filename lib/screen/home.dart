import 'package:cancer_free/screen/bmi.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_task_outlined), label: '')
            ]),
        appBar: AppBar(actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
        ], automaticallyImplyLeading: false, title: const Text('Cancer Free')),
        body: ListView(children: [
          const SizedBox(height: 20),
          const Banners(),
          const Text('Calculate Your BMI'),
          GestureDetector(
              onTap: () {
                navigateTo(screen: const BmiPage(), context: context,state: (){});
              },
              child: Lottie.asset("assets/bmi.json", height: 100, width: 200))
        ]));
  }
}

class Banners extends StatelessWidget {
  const Banners({
    Key? key,
  }) : super(key: key);

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
