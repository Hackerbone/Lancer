import 'package:flutter/material.dart';
import 'package:lancer/utils/constants.dart';

Container inputFields(String initValue, Icon widget, bool password,
    TextEditingController controller) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: secondaryText,
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: password ? true : false,
      cursorColor: textWhite,
      style: TextStyle(
        color: textWhite,
      ),
      // initialValue: initValue,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(18.0),
        ),
        // errorText: 'Invalid Email',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: Color(0xffF3F7F0),
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        prefixIcon: widget,
      ),
    ),
  );
}
