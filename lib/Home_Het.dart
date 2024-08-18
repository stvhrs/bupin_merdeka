import 'package:Bupin/models/Het.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

const List<String> list = <String>[
  'SD/MI  I',
  'SD/MI  II',
  'SD/MI  III',
  'SD/MI  IV',
  'SD/MI  V',
  'SD/MI  VI',
  'SMP/MTS  VII',
  "SMP/MTS  VIII",
  "SMP/MTS  IX",
  "SMA/MA  X",
  "SMA/MA  XI",
  "SMA/MA  XII"
];
List<String> listKelas = <String>[
  'I',
  'II',
  'III',
  'IV',
  'V',
  'VI',
  'VII',
  "VIII",
  "IX",
  "X",
  "XI",
  "XII"
];

class HalmanHet extends StatefulWidget {
  const HalmanHet({super.key});

  @override
  State<HalmanHet> createState() => _HalmanHetState();
}

class _HalmanHetState extends State<HalmanHet> with AutomaticKeepAliveClientMixin{
  List<Het> listHET = [];

  Future<void> fetchApi() async {
    try {
      listHET.clear();
      final dio = Dio();
      int data = list.indexOf(dropdownValue);
      final response =
          await dio.get("https://bupin.id/api/het?kelas=${listKelas[data]}");

      if (response.statusCode == 200) {
        for (Map<String, dynamic> element in response.data) {
          log(element.toString());
          listHET.add(Het.fromMap(element));
        }

        setState(() {});
      }
    } catch (e) {
      log("errrorrr");
    }
  }
bool isPhone = false;
  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    log("het");
    return LayoutBuilder(builder: (context, constraint) {
        isPhone = constraint.maxWidth < 550;
        return Column(
          children: [
            
            Stack(
              alignment: Alignment.center,
              children: [Positioned.fill(
                child: Container(
              color: Theme.of(context).primaryColor,
            )),
                Transform.flip(
                    flipX: false,
                    child: Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        "asset/Halaman_Scan/Cahaya Halaman Scan@4x.png",
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                    right: 20,
                    bottom: 10,
                    child: Image.asset(
                      "asset/Halaman_HET/Bukut Het-9.png",
                      width: constraint.maxWidth * 0.28,
                    )),
                 Positioned(
                    left: 10,
                    bottom: 10,
                    child: Text(
                      "Buku Sekolah\nElektronik (BSE)",
                      style: TextStyle(
                          height:isPhone? 1.22:1,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 15,
                                color: Colors.white),
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 5.0,
                              color: Color.fromARGB(123, 37, 37, 37),
                            ),
                          ],
                          fontSize:isPhone? 20:30,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic),
                    )),
                Positioned(
                    left: 10,
                    top: 30,
                    child: Container(decoration: BoxDecoration(shape:BoxShape.circle,color: Colors.white ),
                      
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset(
                            "asset/Halaman_HET/kemendikbud.png",
                            height: isPhone?  constraint.maxWidth * 0.19 * 9 / 16:constraint.maxWidth * 0.19/3 ,
                          ),
                        ))),
              ],
            ),
            Container( padding:
                    isPhone? EdgeInsets.all(7):EdgeInsets.only(top: 7,bottom: 7,left: 14,right: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "asset/Halaman_HET/Logo Kurmer.png",
                      width: constraint.maxWidth * 0.21,
                    ),
                    Container(
                       height:isPhone?  constraint.maxWidth * 0.19 * 9 / 16:constraint.maxWidth * 0.19 * 9 / 28,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        padding: EdgeInsets.zero,
                        value: dropdownValue,
                        dropdownColor: Colors.white,
                        iconEnabledColor: const Color.fromARGB(255, 66, 66, 66),
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_downward_rounded,
                            size: 16,
                            weight: 10,
                          ),
                        ),
                        elevation: 16,
                        style: const TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 66, 66, 66)),
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
        
                          dropdownValue = value!;
                          setState(() {});
                          fetchApi();
                        },
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            
            listHET.isEmpty
                ? Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.white,
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: listHET.length,
                        gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisCount: isPhone? 2:3,
                                childAspectRatio: 0.8),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              splashColor: Theme.of(context).primaryColor,
                              hoverColor: Theme.of(context).primaryColor,
                              highlightColor: Theme.of(context).primaryColor,
                              focusColor: Theme.of(context).primaryColor,
                              onTap: () {
                                _launchInBrowser(Uri.parse(listHET[index].pdf));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width:
                                       isPhone?   constraint.maxWidth * 0.3:  constraint.maxWidth * 0.2,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: FadeInImage(
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  "asset/place.png",
                                                );
                                              },
                                              image: NetworkImage(
                                                listHET[index].imgUrl,
                                              ),
                                              placeholder: const AssetImage(
                                                "asset/place.png",
                                              ),
                                            )),
                                      ),
                                    ),
                                    Center(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(
                                        listHET[index].namaBuku,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(255, 66, 66, 66),
                                          fontSize: 10,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    )),
                                  ])),
                        ),
                      ),
                    ),
                  )
          ],
        );
      }
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
