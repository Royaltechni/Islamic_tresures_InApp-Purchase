import 'package:flutter/material.dart';
import 'package:kidsapp/models/Categories.dart';
import 'package:kidsapp/models/catgoriess.dart';
import 'package:kidsapp/models/db.dart';

class Azkarprovider with ChangeNotifier {
  // Azkarr azkar;
  Categories categories;
  Categoriess categoriess;

  Future<void> fetchazkarbyid(int id) async {
    try {
      categoriess = await Dbhandler.instance.gethadithbyid(id);
    } catch (error) {
      print('errorrrrrr');
    }
  }

  Future<void> fetchallcatgories(String language, int page) async {
    try {
      categories = await Dbhandler.instance.getallcategries(language, page);
    } catch (error) {
      print('errorrrr');
    }
  }
}
