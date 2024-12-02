import 'package:fanchip_mobile/main_layout.dart';
import 'package:fanchip_mobile/screen/auth_page.dart';
import 'package:fanchip_mobile/screen/hewan/createHewan_page.dart';
import 'package:fanchip_mobile/screen/hewan/updateHewan_page.dart';
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

        // hewan
        '/addHewan': (context) => const CreatehewanPage(),
        '/editHewan': (context) => const UpdatehewanPage()
      },
    );
  }
}