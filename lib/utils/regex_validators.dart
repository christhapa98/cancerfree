import 'package:flutter/services.dart';

//regex validations

//integer regex which ensures integer validation
final FilteringTextInputFormatter integerRegex =
    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+'));

//integer regex which ensures double validation
final FilteringTextInputFormatter doubleRegex =
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
