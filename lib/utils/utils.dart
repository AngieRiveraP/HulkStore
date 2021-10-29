import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

class _Utils {

  /*method to format a value according to the currency*/
  String getFormatCurrencySymbol(String value, String symbol) {
      String cash = '';
      var format = new NumberFormat.currency(locale: "en_US", symbol: r"$", decimalDigits: 0);
      cash = format.format(double.parse(value));
      cash = cash.replaceAll(".", "-");
      cash = cash.replaceAll(",", "/");
      cash = cash.replaceAll("/", ".");
      cash = cash.replaceAll("-", ",");
      return cash;
  }

}

final utils = _Utils();
