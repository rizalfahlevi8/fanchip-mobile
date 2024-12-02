import 'package:fanchip_mobile/screen/give_birth_page.dart';
import 'package:fanchip_mobile/screen/home_page.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page, // Tambahkan controller di sini
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: const [
          HomePage(),
          GiveBirthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
          });
          _page.animateToPage(
            page,
            duration:
                const Duration(milliseconds: 500), // Perbaikan waktu animasi
            curve: Curves.easeInOut,
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot),
            label: 'Give Birth',
          ),
        ],
      ),
    );
  }
}
