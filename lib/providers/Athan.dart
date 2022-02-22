import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidsapp/models/Athan.dart';
import 'package:kidsapp/models/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Athanprovider with ChangeNotifier {
  Athan time;
  String salah;
  String timee;
    DateTime datetime = DateTime.now();
  var duhr;
  var asr;
  var maghrib;
  var isha;
  var fajr;
  var hour1;
  static String fajrtime, asrtime, duhrtime, ishatime, maghribtime;

  Future<void> fetchtimes() async {
    try {
      time = await Dbhandler.instance.gettimes();

      //   fajrtime = int.parse(time.data.timings.fajr.split(':').last);
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("fajrtime", time.data.timings.fajr);
      prefs.setString("asrtime", time.data.timings.asr);
      prefs.setString("durtime", time.data.timings.dhuhr);
      prefs.setString("maghribtime", time.data.timings.maghrib);
      prefs.setString("ishatime", time.data.timings.isha);
    } catch (error) {
      print('errorrrrrr');
    }
  }

  getLan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Athanprovider.fajrtime = prefs.getString("fajrtime");
    Athanprovider.asrtime = prefs.getString("asrtime");
    Athanprovider.duhrtime = prefs.getString("durtime");
    Athanprovider.maghribtime = prefs.getString("maghribtime");
    Athanprovider.ishatime = prefs.getString("ishatime");
    notifyListeners();
  }
  /*
   getnextprayer() {
    var format = DateFormat("HH:mm");
    hour1 = format.parse("${datetime.hour}:${datetime.minute}");

    maghrib = format.parse(time.data.timings.maghrib);
    isha = format.parse(time.data.timings.isha);
    fajr = format.parse(time.data.timings.fajr);
    duhr = format.parse(time.data.timings.dhuhr);
    asr = format.parse(time.data.timings.asr);

    if (hour1.isAfter(isha) || hour1.isBefore(fajr)) {
      salah = 'Fajr';

      timee = time.data.timings.fajr;
    }
    if (hour1.isAfter(fajr) && hour1.isBefore(duhr)) {
      salah = 'Thuhr';

      timee = time.data.timings.dhuhr;
    }
    if (hour1.isAfter(duhr) && hour1.isBefore(asr)) {
      timee = time.data.timings.asr;

      salah = 'Asr';
    }
    if (hour1.isAfter(asr) && hour1.isBefore(maghrib)) {
      salah = 'Maghrib';

      timee = time.data.timings.maghrib;
    }
    if (hour1.isAfter(maghrib) && hour1.isBefore(isha)) {
      timee = time.data.timings.isha;

      salah = 'isha`';
    }
    notifyListeners();
   // return salah + timee;
  }
  */
/*
  savedsalah() async {
    fajr = time.data.timings.fajr;
    duhr = time.data.timings.dhuhr;
    asr = time.data.timings.asr;
    maghrib = time.data.timings.maghrib;
    isha = time.data.timings.isha;

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fajr", fajr);
    prefs.setString("duhr", duhr);
    prefs.setString("asr", asr);
    prefs.setString("maghrib", maghrib);
    prefs.setString("isha", isha);
  }

  getsalah() async {
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(fajr);
    prefs.getString(duhr);
    prefs.getString(asr);
    prefs.getString(maghrib);
    prefs.getString(isha);
  }
  */
}
