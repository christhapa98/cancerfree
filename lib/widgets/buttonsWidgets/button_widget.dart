// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//Custom Button Widget which can be used in diffrent screens throughout our project.
//Reduces code duplication
//Easier to use and see the magic happening.
class ButtonWidget extends StatelessWidget {
  //Default constructor of our ButtonWidget which takes parameters title-String and onPressed-Function.
  //this.title and this.onPressed refers and set values to the Properties defined below
  ButtonWidget({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  //Properties which can be passed as parameters and used in out custom button widget.
  Function onPressed;
  String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: const Color(0xFFEC6E0E),shape: RoundedRectangleBorder()),
            onPressed: () {
              onPressed();
            },
            child: Text(title, style: const TextStyle(color: Colors.white))));
  }
}
