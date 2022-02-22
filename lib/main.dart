import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kidsapp/CheackUserSubscribe.dart';
import 'package:kidsapp/providers/Athan.dart';
import 'package:kidsapp/providers/Namesofallah.dart';
import 'package:kidsapp/providers/azkarprovider.dart';
import 'package:kidsapp/providers/deedprovider.dart';
import 'package:kidsapp/providers/duaaprovider.dart';
import 'package:kidsapp/providers/hadithprovider.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/quraanprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/aboutus.dart';
import 'package:kidsapp/screens/azkar.dart';
import 'package:kidsapp/screens/dialyhadith.dart';
import 'package:kidsapp/screens/duaas.dart';
import 'package:kidsapp/screens/favouritesquraan.dart';
import 'package:kidsapp/screens/login.dart';
import 'package:kidsapp/screens/privacy.dart';
import 'package:kidsapp/screens/settings.dart';
import 'package:kidsapp/screens/signup.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/screens/sours.dart';
import 'package:kidsapp/screens/splash.dart';
import 'package:kidsapp/screens/ramdanscreen.dart';
import 'package:kidsapp/screens/salah.dart';
import 'package:kidsapp/screens/Home.dart';
import 'package:kidsapp/widgets/duadetails.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'screens/login.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  AndroidNotification android = message.notification?.android;
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          playSound: true,
          priority: Priority.high,
          icon: android.smallIcon,
          importance: Importance.high,
          channelShowBadge: true,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
  showBadge: true,
  enableLights: true,
  enableVibration: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
      
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Athanprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Networkprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Userprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Azkarprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Hadithprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Duaaprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Deedprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Lanprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Quraanprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Namesofallahprovider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon,
                playSound: true,
                importance: Importance.high,
                channelShowBadge: true,
              ),
            ));
      }
    });
    getToken();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    initPlatformState();
    return MaterialApp(
        title: 'Islamiccity',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(184, 95, 143, 1),
          accentColor: Color.fromRGBO(167, 85, 163, 1),
        ),
        home: FutureBuilder(
          future:
              Provider.of<Userprovider>(context, listen: false).isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Splash();
            } else if (snapshot.data == true) {
              return Splash();
            } else {
              return Login();
            }
          },
        ),
        routes: {
          Privacy.route: (context) => Privacy(),
          Login.route: (context) => Login(),
          Aboutus.route: (context) => Aboutus(),
          Settings.route: (context) => Settings(),
          Salah.route: (context) => Salah(),
          Ramdan.route: (context) => Ramdan(),
          Duadetails.route: (context) => Duadetails(),
          Duaas.route: (context) => Duaas(),
          Azkar.route: (context) => Azkar(),
          Home.route: (context) => Home(),
          Dialyhadith.route: (context) => Dialyhadith(),
          Surz.route: (context) => Surz(),
          Soura.route: (context) => Soura(),
           Signup.route: (context) => Signup(),
          Favouritesquraanscreen.route: (context) => Favouritesquraanscreen(),
        });
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
  }
  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    if (Platform.isAndroid) {
      await Purchases.setup("goog_dVTdoNdYWkZciAlPEvCSdrkfXGg");
    } else if (Platform.isIOS) {
      await Purchases.setup("appl_KzPfpEvFljFIUeCfRYxBcLvXOto");
    }
    GetSubscriptionStatus();
  }
  Future<void> GetSubscriptionStatus() async {
    try {
      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      if (purchaserInfo.entitlements.all["premium"].isActive) {
        // Grant user "pro" access
       CheackUserSubscribe.isUserSubscribe=true;
      }
    } on PlatformException catch (e) {
      // Error fetching purchaser info
    }
  }
}
