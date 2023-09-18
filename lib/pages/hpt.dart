import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/layout/sidebar.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/view_hama.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/view_penyakit.dart';

class HPT extends StatelessWidget {
  const HPT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226, 1),
      appBar: AppBar(
        title: Text('Hama dan Penyakit'),
        backgroundColor: Color.fromRGBO(11, 166, 8, 1),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewHama(),
                    ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/icon_menu_hama.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPenyakit(),
                    ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/icon_menu_penyakit.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newImage(BuildContext context, String url, MaterialPageRoute route) {
    return InkWell(
      onTap: () {
        // Navigator.pop(context);
        Navigator.push(context, route);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          url,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.height * 0.35,
        ),
      ),
    );
  }
}
