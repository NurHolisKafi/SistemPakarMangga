import 'package:flutter/material.dart';
// import 'package:pendeteksi_kerusakan_mangga/controller/user_controller.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/bantuan.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/dashboard.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/diagnosa.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/hpt.dart';
// import 'package:pendeteksi_kerusakan_mangga/pages/login.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // Future<String?> getTitle() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.containsKey('nama')) {
  //     String nama = pref.getString('nama') ?? '';
  //     return nama.toUpperCase();
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 120,
          width: double.infinity,
          color: Color.fromRGBO(99, 243, 76, 1),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'WELCOME',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          // FutureBuilder<String?>(
          //   future: getTitle(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Align(
          //         alignment: Alignment.center,
          //         child: Text(
          //           snapshot.data.toString(),
          //           style: TextStyle(fontSize: 25, color: Colors.white),
          //         ),
          //       );
          //     }
          //     return Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           width: 160,
          //           height: 40,
          //           color: Color.fromRGBO(24, 215, 20, 1),
          //           child: Material(
          //             color: Colors.transparent,
          //             child: InkWell(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                         builder: (context) => Login(),
          //                       ));
          //                 },
          //                 child: Center(
          //                     child: textWhite(teks: 'Masuk', size: 15))),
          //           ),
          //         )
          //       ],
          //     );
          //   },
          // ),
        ),
        Column(
          children: [
            listMenu(
                'Home',
                Icon(Icons.home),
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                )),
            listMenu('Diagnosa', Icon(Icons.list_alt_outlined),
                MaterialPageRoute(builder: (context) => Diagnosa())),
            listMenu(
                'Hama dan Penyakit',
                Icon(Icons.bug_report_outlined),
                MaterialPageRoute(
                  builder: (context) => const HPT(),
                )),
            listMenu(
                'Bantuan',
                Icon(Icons.help),
                MaterialPageRoute(
                  builder: (context) => const Bantuan(),
                )),
            // FutureBuilder<String?>(
            //   future: getTitle(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return ListTile(
            //         leading: Icon(Icons.logout),
            //         title: Text('Logout'),
            //         onTap: () {
            //           QuickAlert.show(
            //             context: context,
            //             type: QuickAlertType.confirm,
            //             title: 'Logout',
            //             text: 'Anda Yakin Ingin Logout ?',
            //             confirmBtnText: 'Yes',
            //             cancelBtnText: 'No',
            //             confirmBtnColor: Colors.green,
            //             onConfirmBtnTap: () async {
            //               await UserController().logout();
            //               // ignore: use_build_context_synchronously
            //               Navigator.pushReplacement(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => Dashboard(),
            //                   ));
            //             },
            //           );
            //         },
            //       );
            //     }
            //     return Container();
            //   },
            // )
          ],
        )
      ]),
    );
  }

  Widget listMenu(String title, Icon icon, MaterialPageRoute route) {
    return Builder(builder: (context) {
      return ListTile(
        leading: icon,
        title: Text(title),
        onTap: () {
          Navigator.pushReplacement(context, route);
        },
      );
    });
  }
}
