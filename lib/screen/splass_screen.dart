import 'package:flutter/material.dart';

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
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
            context, '/auth'); // Ganti dengan route yang diinginkan
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/fikkia.png',
                                    width: 120, height: 120),
                                const SizedBox(width: 20),
                                Image.asset('assets/images/fanchip.png',
                                    width: 300, height: 200),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'FIKIA Animal Chip (FANCHIP) adalah sebuah program digital yang dirancang khusus untuk membantu pemilik hewan peliharaan mengelola dan melacak data hewan kesayangan mereka. Aplikasi ini terhubung dengan mikrochip yang telah ditanamkan di tubuh hewan, sehingga memberikan berbagai manfaat yang sangat berguna',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    height: 1.6),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/fikkia.png',
                                width: 130, height: 130),
                            const SizedBox(height: 14),
                            Image.asset('assets/images/fanchip.png',
                                width: 300, height: 100),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'FIKIA Animal Chip (FANCHIP) adalah sebuah program digital yang dirancang khusus untuk membantu pemilik hewan peliharaan mengelola dan melacak data hewan kesayangan mereka. Aplikasi ini terhubung dengan mikrochip yang telah ditanamkan di tubuh hewan, sehingga memberikan berbagai manfaat yang sangat berguna',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    height: 1.6),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, '/auth');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
