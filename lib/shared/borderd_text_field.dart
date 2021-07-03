import 'package:flutter/material.dart';

class BorderdTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final bool obscureText;
  final void Function(String) onChanged;
  final String Function(String) validatior;
  final String initVal;

  final bool isLast;
  BorderdTextField(
      {this.hintText,
      this.prefixIconData,
      this.obscureText = false,
      this.onChanged,
      this.validatior,
      this.isLast,
      this.initVal});

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return TextFormField(
      initialValue: initVal,
      onEditingComplete: isLast ? null : () => node.nextFocus(),
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      validator: validatior,
      obscureText: obscureText,
      cursorColor: Colors.blue,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.blue),
        focusColor: Colors.blue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Colors.blue,
        ),
      ),
    );
  }
}
