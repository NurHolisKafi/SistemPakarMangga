import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pendeteksi_kerusakan_mangga/layout/sidebar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pendeteksi_kerusakan_mangga/layout/timer.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/bantuan.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/diagnosa.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/hpt.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends TimeoutMixin<Dashboard> {
  final img = ['assets/caption1.png', 'assets/caption2.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226, 1),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(11, 166, 8, 1),
      ),
      drawer: const MyDrawer(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          resetTimer();
        },
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: CarouselSlider.builder(
                itemCount: 2,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      img[index],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.75,
                    ),
                  );
                },
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.width * 0.45,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height)),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Diagnosa(),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/diagnostic.png',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.height * 0.12,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('Diagnosa')),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HPT(),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/virus.jpg',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.height * 0.13,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Hama dan Penyakit',
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bantuan(),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/tanda-tanya.jpg',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.height * 0.12,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('Bantuan')),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      title: 'Keluar',
                      text: 'Anda Yakin Ingin Keluar ?',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No',
                      confirmBtnColor: Colors.green,
                      onConfirmBtnTap: () {
                        // ignore: use_build_context_synchronously
                        SystemNavigator.pop();
                      });
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/exit.jpg',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.height * 0.12,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('Keluar')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
