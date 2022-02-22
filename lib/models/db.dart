import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:kidsapp/models/Allrecord.dart';
import 'dart:async';
import 'package:kidsapp/models/Athan.dart';
import 'package:kidsapp/models/Categories.dart';
import 'package:kidsapp/models/Hadith.dart';
import 'package:kidsapp/models/Hadithbyid.dart';

import 'package:kidsapp/models/Homedata.dart';
import 'package:kidsapp/models/Hosnasave.dart';
import 'package:kidsapp/models/PaymentInformation.dart';
import 'package:kidsapp/models/Salahsummry.dart';
import 'package:kidsapp/models/Top_student.dart';
import 'package:kidsapp/models/ayaaudio.dart';
import 'package:kidsapp/models/ayacheak.dart';
import 'package:kidsapp/models/ayah.dart';
import 'package:kidsapp/models/ayasaves.dart';
import 'package:kidsapp/models/catgoriess.dart';
import 'package:kidsapp/models/cheakactive.dart';
import 'package:kidsapp/models/dialyhadith.dart';
import 'package:kidsapp/models/favouritehadith.dart';
import 'package:kidsapp/models/hadithlevel.dart';
import 'package:kidsapp/models/quraanffavourite.dart';
import 'package:kidsapp/models/quraanlevles.dart';
import 'package:kidsapp/models/sour.dart';
import 'package:kidsapp/models/score.dart';
import 'package:kidsapp/models/sourarecord.dart';
import 'package:kidsapp/models/user.dart';
import 'package:kidsapp/models/vedio.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/signup.dart';
import 'dart:convert' as convert;
import 'Namesofallah.dart';
import 'sourafavourite.dart';
import 'guz2save.dart';

class Dbhandler {
  static Dbhandler _instance = Dbhandler._private();
  Dbhandler._private();
  static Dbhandler get instance => _instance;
  Dio _dio = Dio();
  int cheaksalah;
  int hadithreadd;
  int deedreadd;
  int duaareadd;
  int counter;
  int azkarreadd;
  int ramdanstatuss;
  int athancheak;
  int dialyhadith;
  int dialhadithstatuscode;
  int homestatuscode;
  int hosnastatuscode;
  int azkarstatuscode;
  int sourastatuscode;
  int quraanstatuscode;
  int ramadanstatuscode;
  String mainurl = 'https://muslimkids.royaltechni.com/api';
  int favouritestatuscode;
  int sourarecord;
  Future<Athan> gettimes() async {
    String city = Userprovider.city;
    String country = Userprovider.country;
    String method;

    if (country == 'MAKKAH' || country == 'United Arab Emirates') {
      method = '4';
    } else if (country == 'Egypt' ||
        country == 'Syria' ||
        country == 'Lebanon' ||
        country == 'Malaysia') {
      method = '5';
    }
    try {
      String url =
          'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=$method';
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      athancheak = response.statusCode;
      // print(response.body);
      //  statuscode = response.statusCode;
      return Athan.fromJson(json.decode(response.body) as Map<String, dynamic>);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<Categories> getallcategries(String language, int page) async {
    String url = '$mainurl/categories?page=$page';
    _dio.options.headers["Accept-Language"] = "$language";
    Response response = await _dio.get(url);
    azkarstatuscode = response.statusCode;
    return Categories.fromJson(response.data);
  }

  Future<Categoriess> gethadithbyid(int id) async {
    String url = '$mainurl/categories/$id';

    Response response = await _dio.get(url);
    //  print(response.data);
    return Categoriess.fromJson(response.data);
  }

  Future<Hadith> getallhadith() async {
    String url = '$mainurl/hadith';
    Response response = await _dio.get(url);
    ramadanstatuscode = response.statusCode;
    return Hadith.fromJson(response.data);
  }

  Future<Hadith> getallduuas() async {
    String url = '$mainurl/duaa';
    Response response = await _dio.get(url);
    ramadanstatuscode = response.statusCode;
    return Hadith.fromJson(response.data);
  }

  Future<Hadith> getalldeed() async {
    String url = '$mainurl/deed';
    Response response = await _dio.get(url);
    ramadanstatuscode = response.statusCode;
    return Hadith.fromJson(response.data);
  }

  Future<User> signIn(String email, String password) async {
    String url = '$mainurl/login';
    Response response = (await _dio.post(
      url,
      data: {
        'name': email,
        'password': password,
      },
    ));
    print(response.data);
    print(response.statusCode);
    return User.fromjson(response.data);
  }

  Future<User> Signup(String username, String password, String cpassword,
      String phone, String email) async {
    String url = '$mainurl/user';
    Response response = (await _dio.post(
      url,
      data: {
        'name': username,
        'password': password,
        'c_password': cpassword,
        'phone': phone,
        'email': email,
      },
    ));
    print(response.data);
    print(response.statusCode);
    return User.fromjsonn(response.data);
  }

  Future<void> azkarread(String status, String categoryid) async {
    String url = '$mainurl/azkar_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'status': status,
          'category_id': categoryid,
        },
      );
      azkarreadd = response.statusCode;
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> hadithread(String hadithid, String status) async {
    String url = '$mainurl/hadith_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'hadith_id': hadithid,
          'status': status,
        },
      );
      hadithreadd = response.statusCode;
      //  print(response.statusCode);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> duaaread(String duaaid, String status) async {
    String url = '$mainurl/duaa_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'duaa_id': duaaid,
          'status': status,
        },
      );
      duaareadd = response.statusCode;
      //     print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> deaedread(String duaaid, String status) async {
    String url = '$mainurl/deed_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'deed_id': duaaid,
          'status': status,
        },
      );
      deedreadd = response.statusCode;
      //  print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> salahevluate(String salahid, String status, String zekr) async {
    String url = '$mainurl/salah_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'salah_id': salahid,
          'status': status,
          'StatusOfZkr': zekr,
        },
      );
      cheaksalah = response.statusCode;
      print(response.statusCode);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> ramdanstatus(String status) async {
    String url = '$mainurl/ramadan_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'status': status,
        },
      );
      //  print(response.body);
      ramdanstatuss = response.statusCode;
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> activity(String status, String activityid) async {
    String url = '$mainurl/activity_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {'activity_id': activityid, 'status': status},
      );
      //  print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> quraantracker(String aya, String soura, String goz) async {
    String url = '$mainurl/quran_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {'countOfAya': aya, 'countOfSoura': soura, 'countOfGoza': goz},
      );
      counter = response.statusCode;
      //   print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<Score> getscore() async {
    String url = '$mainurl/score';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    try {
      Response response = await _dio.get(url);
      homestatuscode = response.statusCode;
      return Score.fromJson(response.data);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<Sour> getsour() async {
    String url = 'https://api.alquran.cloud/v1/surah';
    Response response = await _dio.get(url);
    quraanstatuscode = response.statusCode;
    return Sour.fromJson(response.data);
  }

  Future<Ayah> getayatbyid(int id, int limit) async {
    String url =
        'https://api.quran.sutanlab.id/surah/$id?offset=1&limit=$limit';

    var response = await http.get(Uri.parse(url));
    sourastatuscode = response.statusCode;
    return Ayah.fromJson(convert.jsonDecode(response.body));
  }

  Future<void> azkaraftersalah(String status, String id) async {
    String url = '$mainurl/azkar_salah_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {'status': status, 'salah_id': id},
      );
      //  print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> Dialyhadithstatus(String status, String hadithid) async {
    String url = '$mainurl/dailyhadith_status';
    final String tokenn = Userprovider.sd;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'status': status,
          'dailyhadith_id': hadithid,
        },
      );
      dialyhadith = response.statusCode;
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> strothafithrecord(
      String status, String hadithid, File file) async {
    String url = '$mainurl/record_hadith';
    final String tokenn = Userprovider.sd;
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "audio": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      'is_update': status,
      'hadith_id': hadithid,
    });
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    _dio.options.headers["Accept"] = "application/json";
    Response response = await _dio.post(
      url,
      data: data,
    );
    print(response.statusCode);
  }

  Future<void> ayasave(String soraid, String ayaid, String surah, String juza,
      String status) async {
    String url = '$mainurl/quran_saves';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'quran_number': soraid,
          'numberOfVerse': ayaid,
          'surah': surah,
          'juza': juza,
          'status': status,
        },
      );
      print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> ayarecord(
      String soraid, String ayaid, String surah, String juza, File file) async {
    String url = '$mainurl/quran_saves';
    final String tokenn = Userprovider.sd;
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "audio": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      'quran_number': soraid,
      'numberOfVerse': ayaid,
      'surah': surah,
      'juza': juza,
      'status': 'read',
    });
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    _dio.options.headers["Accept"] = "application/json";
    Response response = await _dio.post(
      url,
      data: data,
    );
    print(response.data);
  }

  Future<Ayasaves> getayasaves(int id) async {
    String url = '$mainurl/numberOfSaves/$id';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";

    Response response = await _dio.get(url);
    print(response.statusCode);

    return Ayasaves.fromJson(response.data);
  }

  Future<Ayasaves> getlevelsaves(int id) async {
    String url = '$mainurl/numberOfSavesThroughLevel/$id';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";

    Response response = await _dio.get(url);
    print(response.data);

    return Ayasaves.fromJson(response.data);
  }

  Future<Ayacheak> getayacheak(int id) async {
    String url = '$mainurl/allOfVerseSave/$id';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";

    Response response = await _dio.get(url);
    sourastatuscode = response.statusCode;
    return Ayacheak.fromJson(response.data);
  }

  Future<Ayasaves> getallOfVerseSave(int id) async {
    String url = '$mainurl/allOfVerseSave/$id';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";

    Response response = await _dio.get(url);

    return Ayasaves.fromJson(response.data);
  }

  Future<Juz2save> getguzsaved() async {
    String url = '$mainurl/numberOfAllJuzaSaves';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";

    Response response = await _dio.get(url);
    quraanstatuscode = response.statusCode;
    return Juz2save.fromJson(response.data);
  }

  Future<Quraanlevels> getlevles() async {
    String url = '$mainurl/QuranLevels';

    Response response = await _dio.get(url);
    quraanstatuscode = response.statusCode;
    return Quraanlevels.fromJson(response.data);
  }

  Future<Dailyhadith> getdialyhadith(int page) async {
    String url = '$mainurl/dailyhadith?page=$page';
    Response response = await _dio.get(url);
    dialhadithstatuscode = response.statusCode;
    return Dailyhadith.fromJson(response.data);
  }

  Future<Hadithlevel> gethadithleevel() async {
    String url = '$mainurl/HadithLevels';
    Response response = await _dio.get(url);
    //  print(response.data);
    return Hadithlevel.fromJson(response.data);
  }

  Future<Homedata> gethomedata() async {
    String url = '$mainurl/homepage';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    Response response = await _dio.get(url);
    homestatuscode = response.statusCode;
    return Homedata.fromJson(response.data);
  }

  Future<Namesofallah> getnamesofallah(int page) async {
    String url = '$mainurl/hosna?page=$page';
    Response response = await _dio.get(url);
    hosnastatuscode = response.statusCode;
    return Namesofallah.fromJson(response.data);
  }

  Future<Hosnasave> gethosnasaved() async {
    String url = '$mainurl/hosnaSave';
    Response response = await _dio.get(url);
    return Hosnasave.fromJson(response.data);
  }

  Future<void> namesofallahsaved(String id) async {
    String url = '$mainurl/hosna_status';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {'hosna_id': id, 'status': 'read'},
      );
      print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> hosnarecord(File file) async {
    String url = '$mainurl/hosnaRecord';
    final String tokenn = Userprovider.sd;
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "audio": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    _dio.options.headers["Accept"] = "application/json";
    Response response = await _dio.post(
      url,
      data: data,
    );
    print(response.data);
    print(response.statusCode);
  }

  Future<void> sourarecrod(
      File file, int juzid, int souraid, String value) async {
    String url = '$mainurl/record_quran';
    final String tokenn = Userprovider.sd;
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "audio": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      'quran_number': souraid,
      'juza': juzid,
      'is_update': value,
    });
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    _dio.options.headers["Accept"] = "application/json";
    Response response = await _dio.post(
      url,
      data: data,
    );
    sourarecord = response.statusCode;
    print(response.statusCode);
  }

  Future<Vedio> gethosnavedio() async {
    String url = '$mainurl/hosnaVideo';
    Response response = await _dio.get(url);
    hosnastatuscode = response.statusCode;
    return Vedio.fromJson(response.data);
  }

  Future<Salahsummary> getsalahsumrry(int id) async {
    String url = '$mainurl/salahDetails/$id';
    Response response = await _dio.get(url);
    return Salahsummary.fromJson(response.data);
  }

  Future<Topstudents> gettopstudents() async {
    String url = '$mainurl/topStudent';
    Response response = await _dio.get(url);
    homestatuscode = response.statusCode;
    return Topstudents.fromJson(response.data);
  }

  Future<void> hadithfav(String hadithid) async {
    String url = '$mainurl/storeFavouriteHadith';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'hadith_id': hadithid,
        },
      );
      print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> quraanfavourite(String soraid, String juzid) async {
    String url = '$mainurl/storeFavouriteQuran';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: {
          'quran_number': soraid,
          'juza': juzid,
        },
      );
      print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<Favouritehadith> getfavouritehadith() async {
    String url = '$mainurl/showFavouriteHadith';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    Response response = await _dio.get(url);
    // print(response.data);
    return Favouritehadith.fromJson(response.data);
  }

  Future<Quraanfavourites> getfavouritequraan() async {
    String url = '$mainurl/showListFavourite';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    Response response = await _dio.get(url);
    favouritestatuscode = response.statusCode;
    return Quraanfavourites.fromJson(response.data);
  }

  Future<Sourarecord> getsourarecord(int juz, int soura) async {
    String url = '$mainurl/isRecordFound/$juz/$soura';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    Response response = await _dio.get(url);
    sourastatuscode = response.statusCode;

    return Sourarecord.fromJson(response.data);
  }

  Future<Sourafavourite> getsouraquran(int juz, int soura) async {
    String url = '$mainurl/showFavouriteQuran/$juz/$soura';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    Response response = await _dio.get(url);
    sourastatuscode = response.statusCode;
    return Sourafavourite.fromJson(response.data);
  }

  Future<Allrecord> getallrecord(int juz, int soura) async {
    String url = '$mainurl/showAllRecords/$juz/$soura';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    Response response = await _dio.get(url);
    print(response.data);
    return Allrecord.fromJson(response.data);
  }

  Future<Allrecord> getallhadithrecord(int hadithid) async {
    String url = '$mainurl/showAllHadithRecords/$hadithid';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    Response response = await _dio.get(url);
    print(response.data);
    return Allrecord.fromJson(response.data);
  }

  Future<void> deleterecord(int recordid) async {
    String url = '$mainurl/deleteRecords/$recordid';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
      );
      print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> deletehadithrecord(int recordid) async {
    String url = '$mainurl/deleteHadithRecords/$recordid';
    final String tokenn = Userprovider.sd;

    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
      );
      print(response.body);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<Topstudents> gettopclassstudents() async {
    String url = '$mainurl/topStudentForClass';
    Response response = await _dio.get(url);
    homestatuscode = response.statusCode;
    return Topstudents.fromJson(response.data);
  }

  Future<Topstudents> gettopexternal() async {
    String url = '$mainurl/topStudentExternal';
    Response response = await _dio.get(url);
    return Topstudents.fromJson(response.data);
  }

  Future<Hadithbyid> getspecifichadith(int id) async {
    String url = '$mainurl/dailyhadith/$id';
    Response response = await _dio.get(url);
    homestatuscode = response.statusCode;
    return Hadithbyid.fromJson(response.data);
  }

  Future<Ayaaudio> ayaaudio(int guzid, int souraid, int ayaid) async {
    String url = '$mainurl/quran_audio';
    final String tokenn = Userprovider.sd;

    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    _dio.options.headers["Accept"] = "application/json";
    Response response = await _dio.post(
      url,
      data: {'juza': guzid, 'quran_number': souraid, 'aya': ayaid},
    );
    return Ayaaudio.fromJson(response.data);
  }

  Future<Active> checkActivity() async {
    String url = '$mainurl/chechActivity';
    final String tokenn = Userprovider.sd;
    _dio.options.headers["Authorization"] = "Bearer $tokenn";

    Response response = await _dio.get(url);

    print(response.data);
    return Active.fromJson(response.data);
  }
  Future<PaymentInformation> SendPaymentInformation(int status,String process_id) async {
    String url = '$mainurl/storePayment';
    final String tokenn = Userprovider.sd;

    _dio.options.headers["Authorization"] = "Bearer $tokenn";
    _dio.options.headers["Accept"] = "application/json";
    Response response = await _dio.post(
      url,
      data: {'status': status ,'process_id': process_id},
    );

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return PaymentInformation.fromJson(response.data);
  }
}
