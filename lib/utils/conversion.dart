import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

//function that converts File into base64 String
String convertImageToBase64(File file) {
  List<int> imageBytes = file.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

// String convertNepaliToEnglishDate(String date) {
//   final List<String> splittedDate = date.split('/');
//   final NepaliDateTime nepaliDate = NepaliDateTime(
//     int.parse(splittedDate[0]),
//     int.parse(splittedDate[1]),
//     int.parse(splittedDate[2]),
//   );
//   return convertDateTimeDisplay(nepaliDate.toDateTime().toString());
// }

// String convertToNepaliDate(String date) {
//   final List<String> splittedDate = date.split('/');
//   final NepaliDateTime nepaliDate = DateTime(
//     int.parse(splittedDate[0]),
//     int.parse(splittedDate[1]),
//     int.parse(splittedDate[2]),
//   ).toNepaliDateTime();
//   final String formattedNepaliDate =
//       convertDateTimeDisplay(nepaliDate.toString());
//   return formattedNepaliDate;
// }

//function to convert hex Color to flutter Material color
Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
