import 'package:shared_preferences/shared_preferences.dart';

class User {
  String token;
  String name;

  User.fromjson(dynamic json)
      : this.token = json['success']['token'];
       User.fromjsonn(dynamic json)
      : this.token = json['token']['token'];
     
  User.fromPrefs(SharedPreferences prefs)
      : this.token = prefs.get('token'),
        this.name = prefs.get('name');

  // this.name = prefs.get('name'),
  //   this.email = prefs.get('email');
  //  this.id =int.parse(prefs.get('id'),);
}
