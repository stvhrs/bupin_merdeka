import 'package:Bupin/Banner.dart';
import 'package:Bupin/Halaman_Soal.dart';
import 'package:Bupin/Home_Het.dart';
import 'package:Bupin/Home_Scan.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.animateTo(1);
  }

  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    HalmanHet(),
    HalmanScan(),
    Text(""),
  ];

  void _onItemTapped(int index) {
    if (index != 2) {
      _selectedIndex = index;
      setState(() {
        _controller.animateTo(index);
      });
    } else {
      _selectedIndex = index;

      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CustomRoute(
                      builder: (context) => const HalamanSoal(
                          "https://tim.bupin.id/cbtakm/login.php?6666",
                          "Bank Soal SD/MI",
                          false,
                          ""),
                    ));
                  },
                  child: Container(
                      color: const Color.fromRGBO(205, 32, 49, 0.1),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SD@4x.png",
                              width: 50),
                        ),
                        const Spacer(),
                        const Text(
                          "SD/MI",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(205, 32, 49, 1),
                              fontSize: 18),
                        ),
                        const Spacer(),
                  Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              color: Colors.transparent,
                              width: 50),
                        ),
                      ])),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CustomRoute(
                      builder: (context) => const HalamanSoal(
                          "https://tim.bupin.id/cbtakm/login.php?7777",
                          'Bank Soal SMP/MTS',
                          false,
                          ""),
                    ));
                  },
                  child: Container(
                      color: const Color.fromRGBO(58, 88, 167, 0.1),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMP@4x.png",
                              width: 50),
                        ),
                        const Spacer(),
                        const Text(
                          "SMP/MTS",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(58, 88, 167, 1),
                              fontSize: 18),
                        ),
                        const Spacer(),
                    Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              color: Colors.transparent,
                              width: 50),
                        ),
                      ])),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CustomRoute(
                      builder: (context) => const HalamanSoal(
                          "https://tim.bupin.id/cbtakm/login.php?9999",
                          'Bank Soal SMA/MA',
                          false,
                          ""),
                    ));
                  },
                  child: Container(
                      color: const Color.fromRGBO(120, 163, 215, 0.1),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              width: 50),
                        ),
                        const Spacer(),
                        const Text(
                          "SMA/MA",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(120, 163, 215, 1),
                              fontSize: 18),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                              "asset/Halaman_Latihan_PAS&PTS/Icon SMA@4x.png",
                              color: Colors.transparent,
                              width: 50),
                        ),
                      ])),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'E-Book BSE',
                backgroundColor: Color.fromARGB(255, 164, 3, 3),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color.fromARGB(255, 164, 3, 3),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_rounded),
                label: 'Bank Soal',
                backgroundColor: Color.fromARGB(255, 164, 3, 3),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 164, 3, 3),
            onTap: _onItemTapped,
          ),
        ),
          const HalamanBanner()
      ],
    );
  }
}
