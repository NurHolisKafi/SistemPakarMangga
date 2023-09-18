import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/dashboard.dart';
// import 'package:pendeteksi_kerusakan_mangga/pages/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      // HasilDiagnosa(),
      // FutureBuilder<Widget>(
      //     future: isLogin(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return snapshot.data!;
      //       }
      //       return Container(
      //           decoration: const BoxDecoration(
      //               image: DecorationImage(
      //                   image: AssetImage('assets/splash_screen.png'),
      //                   fit: BoxFit.cover)),
      //           child: const Scaffold(
      //             backgroundColor: Colors.transparent,
      //             body: Padding(
      //               padding: EdgeInsets.only(bottom: 200),
      //               child: Align(
      //                   alignment: Alignment.bottomCenter,
      //                   child: CircularProgressIndicator()),
      //             ),
      //           ));
      //     }),
      debugShowCheckedModeBanner: false,
    );
  }
}
