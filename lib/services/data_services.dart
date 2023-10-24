import 'dart:convert';
import 'package:flutter/services.dart';

class DataServices {
  Future<List<dynamic>> getUsers() async {
    var info = rootBundle.loadString("json/data.json");
    List<dynamic> list = json.decode(await info);
    return Future.delayed(
        const Duration(seconds: 3), () => list.map((e) => e).toList());
  }
}
