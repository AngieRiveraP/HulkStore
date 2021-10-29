import 'package:flutter/material.dart';
import 'package:hulk_store/utils/colors.dart';

showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, Color backgroundColor, String message, Duration duration){
  _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
          backgroundColor: backgroundColor,
          duration: duration,
          elevation: 0,
          padding: EdgeInsets.only(bottom: 0, top: 0, right: 0, left: 0),
          content: Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 15, left: 15),
            decoration: BoxDecoration(
                color: backgroundColor
            ),
            child:  Text(message,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15.0,
                    color: CustomColors.white))
          )
      ));
}
