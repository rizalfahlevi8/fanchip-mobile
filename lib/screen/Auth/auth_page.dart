import 'package:fanchip_mobile/components/login_form.dart';
import 'package:fanchip_mobile/components/register_form.dart';
import 'package:fanchip_mobile/utils/config.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Config.spaceSmall,
            Text(
              isSignIn ? 'Sign In' : 'Register',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Config.spaceSmall,
            isSignIn ? const LoginForm() : const RegisterForm(),
            Config.spaceSmall,
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Pusatkan Row secara keseluruhan
              children: [
                Expanded(
                  child: Align(
                    alignment:
                        Alignment.centerRight, // Menempatkan teks di kanan
                    child: Text(
                      isSignIn
                          ? 'Apakah kamu sudah daftar?'
                          : 'Sudah memiliki akun?',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft, // Menempatkan teks di kiri
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isSignIn = !isSignIn;
                        });
                      },
                      child: Text(
                        isSignIn ? 'Register' : 'Sign In',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
