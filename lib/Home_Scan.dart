import 'dart:developer';

import 'package:Bupin/Halaman_Camera.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/widgets/scann_aniamtion/scanning_effect.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HalmanScan extends StatefulWidget {
  const HalmanScan({super.key});

  @override
  State<HalmanScan> createState() => _HalmanScanState();
}

class _HalmanScanState extends State<HalmanScan> {
  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    super.didChangeDependencies();
  }

  double width = 0;
  @override
  Widget build(BuildContext context) {
    log("scan");
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 164, 3, 3),
                  const Color.fromARGB(255, 255, 255, 255),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.5, 1.0],
                tileMode: TileMode.clamp),
          ),
          alignment: Alignment.center,
        ),
        Positioned(
          top: 20,
          child: Image.asset(
            "asset/Halaman_Scan/Logo Bupin@4x.png",
            width: width * 0.5,
            color: Colors.white,
          ),
        ),
        Positioned.fill(
            top: 0,
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                  "asset/Halaman_Scan/Cahaya Halaman Scan@4x.png",
                  repeat: ImageRepeat.repeatY,
                  color: Colors.white,
                  width: width),
            )),
        LayoutBuilder(builder: (context, constraint) {
          return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Image.asset("asset/Halaman_Scan/Manusia2.png",
                      width: constraint.maxWidth < 550
                          ? constraint.maxWidth
                          : constraint.maxWidth * 0.7),
                ),
                Positioned(
                  bottom: constraint.maxWidth < 550
                      ? constraint.maxWidth * 0.76
                      : constraint.maxWidth * 0.54,
                  child: Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      width:constraint.maxWidth < 550
                          ? constraint.maxWidth * 0.2: constraint.maxWidth * 0.15,
                      height: constraint.maxWidth < 550
                          ? constraint.maxWidth * 0.2: constraint.maxWidth * 0.15,
                      child: ScanningEffect(
                        enableBorder: false,
                        scanningColor: Colors.white,
                        delay: Duration(milliseconds: 100),
                        duration: Duration(seconds: 2),
                        scanningLinePadding: EdgeInsets.all(0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(CustomRoute(
                              builder: (context) => const QRViewExample(false),
                            ));
                          },
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                color: Colors.white,
                                size:constraint.maxWidth < 550
                          ? constraint.maxWidth * 0.2: constraint.maxWidth * 0.15,
                              )),
                        ),
                      ),
                    ),
                  ]),
                ),
              ]);
        })
      ]),
      backgroundColor: Colors.transparent,
    );
  }
}
