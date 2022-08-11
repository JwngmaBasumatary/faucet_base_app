import 'package:flutter/material.dart';

class DesignForm extends StatelessWidget {
  const DesignForm(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.enabled})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled ?? true,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Field Can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        fillColor: Colors.transparent,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1),
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 3, 6, 3),
      ),
    );
  }
}
