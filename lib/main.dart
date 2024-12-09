import 'package:fanchip_mobile/main_layout.dart';
import 'package:fanchip_mobile/screen/Auth/auth_page.dart';
import 'package:fanchip_mobile/screen/Auth/me_page.dart';
import 'package:fanchip_mobile/screen/hewan/createHewan_page.dart';
import 'package:fanchip_mobile/screen/hewan/updateHewan_page.dart';
import 'package:fanchip_mobile/screen/jenis/createJenis_page.dart';
import 'package:fanchip_mobile/screen/jenis/updateJenis_page.dart';
import 'package:fanchip_mobile/screen/lahir/createLahir_page.dart';
import 'package:fanchip_mobile/screen/lahir/updateLahir_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fanchip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/home': (context) => const MainLayout(),
        '/me' : (context) => const MePage(),

        // hewan
        '/addHewan': (context) => const CreatehewanPage(),
        '/editHewan': (context) => const UpdatehewanPage(),

        //jenis
        '/addJenis': (context) => const CreatejenisPage(),
        '/editJenis': (context) => const UpdatejenisPage(),

        //lahir
        '/addLahir': (context) => const CreatelahirPage(),
        '/editLahir': (context) => const UpdatelahirPage(),
      },
    );
  }
}
