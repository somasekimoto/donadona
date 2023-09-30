import 'dart:convert';

import 'package:flutter/services.dart';

class Util {
  static Future<List<dynamic>> readJson(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data;
  }
}