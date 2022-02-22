import 'package:flutter/material.dart';
import 'package:kidsapp/models/Hosnasave.dart';
import 'package:kidsapp/models/Namesofallah.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/models/vedio.dart';

class Namesofallahprovider with ChangeNotifier {
  Namesofallah namesofallah;
  Hosnasave hosnasaved;
  Vedio video;
  Future<void> fetchnamesofallah(int page) async {
    try {
      namesofallah = await Dbhandler.instance.getnamesofallah(page);
      
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }
  Future<void> fetchnamessaved() async {
    try {
      hosnasaved = await Dbhandler.instance.gethosnasaved();
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }
  Future<void> fetchvedio() async {
    try {
      video = await Dbhandler.instance.gethosnavedio();
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }
}
