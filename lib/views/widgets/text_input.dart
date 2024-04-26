import 'package:flutter/material.dart';
import '../../constant.dart';


class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  final String hintText;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
    required this.hintText,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextField(
        style: const TextStyle(color: Colors.black,fontSize: 15),
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(

          labelText: labelText,
          prefixIcon: Icon(icon),
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black,fontSize: 12),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
        ),
        obscureText: isObscure,
      ),
    );
  }
}