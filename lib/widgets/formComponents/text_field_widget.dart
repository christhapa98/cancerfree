// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.passwordVisible,
      this.isEnabled,
      this.label,
      this.maxLines,
      this.inputFormatter,
      this.inputType,
      this.suffixIcon,
      this.onChanged})
      : super(key: key);

  TextEditingController controller;
  String hintText;
  int? maxLines;
  String? label;
  TextInputType? inputType;
  TextInputFormatter? inputFormatter;
  Widget? suffixIcon;
  bool? passwordVisible;
  bool? isEnabled;
  Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) Text(label!),
          if (label != null) const SizedBox(height: 10),
          TextField(
            enabled: isEnabled ?? true,
            inputFormatters: inputFormatter == null ? [] : [inputFormatter!],
            keyboardType: inputType ?? TextInputType.text,
            maxLines: maxLines ?? 1,
            obscureText: passwordVisible ?? false,
            controller: controller,
            onChanged: (val) {
              if (onChanged != null) {
                onChanged!(val);
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black26),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black26),
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
