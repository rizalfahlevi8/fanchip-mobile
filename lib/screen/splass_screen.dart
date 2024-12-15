import 'package:flutter/material.dart';
import 'package:fanchip_mobile/screen/Auth/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Setelah delay, arahkan ke halaman berikutnya
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, '/auth'); // Ganti dengan route yang diinginkan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background menggunakan gradien
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ganti dengan logo aplikasi Anda
              const Icon(
                Icons.pets, // Ganti dengan ikon atau logo aplikasi Anda
                size: 120,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              // Menambahkan judul aplikasi
              Text(
                'Fanchip',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Deskripsi aplikasi dengan padding
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'FIKIA Animal Chip (FANCHIP) adalah sebuah program digital yang dirancang khusus untuk membantu pemilik hewan peliharaan mengelola dan melacak data hewan kesayangan mereka. Aplikasi ini terhubung dengan mikrochip yang telah ditanamkan di tubuh hewan, sehingga memberikan berbagai manfaat yang sangat berguna.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
