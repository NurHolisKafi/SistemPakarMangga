import 'package:flutter/material.dart';

TextFormField inputFrom(
    {required String hint,
    required String msg,
    required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    enableSuggestions: true,
    style: TextStyle(fontSize: 16),
    // ignore: prefer_const_constructors
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 20, top: 17, bottom: 17),
        hintText: hint,
        hintStyle:
            TextStyle(color: Color.fromRGBO(163, 156, 156, 1), fontSize: 12),
        // ignore: prefer_const_constructors
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.transparent))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return msg;
      }
      return null;
    },
  );
}

TextFormField inputFromPassword(
    {required String hint,
    required String msg,
    required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    enableSuggestions: true,
    obscureText: true,
    autocorrect: false,
    style: TextStyle(fontSize: 16),
    // ignore: prefer_const_constructors
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 20, top: 17, bottom: 17),
        hintText: hint,
        hintStyle:
            TextStyle(color: Color.fromRGBO(163, 156, 156, 1), fontSize: 12),
        // ignore: prefer_const_constructors
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.transparent))),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return msg;
      }
      return null;
    },
  );
}
