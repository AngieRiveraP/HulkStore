import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hulk_store/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final bool isPriceField;
  final String error;
  final EdgeInsets padding;
  final maxLines;
  final controller;

  const CustomTextField({
    required Key key,
    this.hint = '',
    required this.onChanged,
    required this.keyboardType,
    this.isPriceField = false,
    this.error = "",
    required this.maxLines,
    this.padding = const EdgeInsets.all(0),
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        inputFormatters: isPriceField ? <TextInputFormatter>[
           FilteringTextInputFormatter.digitsOnly,
        ] : <TextInputFormatter>[],
        style: TextStyle(
            fontSize: 15.0,
            color: CustomColors.black),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: hint,
          labelText: hint,
          labelStyle: TextStyle(
              fontSize: 15.0,
              color: CustomColors.black),
          hintStyle: TextStyle(
              fontSize: 14.0,
              color: CustomColors.black.withOpacity(0.3)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1, color: CustomColors.black)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1, color: CustomColors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1, color: CustomColors.black)),
        ),
        autocorrect: false,
        textInputAction: TextInputAction.done,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
}
