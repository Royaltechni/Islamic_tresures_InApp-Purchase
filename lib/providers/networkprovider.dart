import 'dart:io';

import 'package:flutter/material.dart';

class Networkprovider with ChangeNotifier {
  static bool cheak;
  Future<void> cheaknetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Networkprovider.cheak = true;
      }
    } on SocketException catch (_) {
      Networkprovider.cheak = false;
    }
  }
}
