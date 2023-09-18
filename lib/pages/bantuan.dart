import 'package:flutter/material.dart';

import '../layout/sidebar.dart';
import '../layout/timer.dart';

class Bantuan extends StatefulWidget {
  const Bantuan({super.key});

  @override
  State<Bantuan> createState() => _BantuanState();
}

class _BantuanState extends TimeoutMixin<Bantuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226, 1),
      appBar: AppBar(
        title: Text('Bantuan'),
        backgroundColor: Color.fromRGBO(11, 166, 8, 1),
      ),
      drawer: MyDrawer(),
      body: ListView(padding: EdgeInsets.all(30), children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            resetTimer();
          },
          child: const Card(
            margin: EdgeInsets.only(bottom: 40),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Center',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email : nurholis195@gmail.com',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Whatsapp : 085930112197'),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            resetTimer();
          },
          child: const Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diagnosa',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Diagnosa merupakan menu untuk memprediksi kerusakan - kerusakan yang terdapat pada tanaman mangga '),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Hama dan Penyakit',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Hama dan penyakit merupakan menu untuk menampilkan daftar  - daftar hama dan penyakit penyebab kerusakan tanaman mangga')
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
