import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/confirm_new_password.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/user_controller.dart';
import '../layout/input_form.dart';

// ignore: must_be_immutable
class LupaPassword extends StatelessWidget {
  LupaPassword({super.key});
  final _key = GlobalKey<FormFieldState<String>>();
  TextEditingController controllerNotelp = TextEditingController();

  String generateUniqueCode(int length) {
    const chars = 'abcdefghijklmnoABCDEFGHIJKL0123456789';
    final random = Random();
    final codeUnits = List.generate(length, (index) {
      return chars.codeUnitAt(random.nextInt(chars.length));
    });
    return String.fromCharCodes(codeUnits);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Background.png'), fit: BoxFit.cover)),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: _key,
            child: Center(
              child: Container(
                height: height,
                padding: EdgeInsets.only(
                  top: 50,
                ),
                width: width * 0.75,
                child: ListView(
                  children: [
                    textWhite(teks: "Reset Password", size: 30),
                    SizedBox(
                      height: 35,
                    ),
                    textWhite(teks: "Masukkan no hp yang terdaftar", size: 13),
                    SizedBox(height: 15),
                    inputFrom(
                        hint: 'NO HP',
                        msg: 'No Hp Tidak Boleh Kosong',
                        controller: controllerNotelp),
                    SizedBox(
                      height: 35,
                    ),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          minimumSize: MaterialStatePropertyAll(Size(253, 50)),
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(73, 88, 103, 1)),
                        ),
                        onPressed: () async {
                          final valid = Form.of(context).validate();
                          if (valid) {
                            final result = await UserController()
                                .getUser(controllerNotelp.text);
                            if (result != null) {
                              final pref =
                                  await SharedPreferences.getInstance();
                              String kode = generateUniqueCode(6);
                              pref.setString('kode', kode);
                              pref.setString(
                                  'user_id', result['id_user'].toString());
                              final sendSMS = UserController()
                                  .sendSMS(controllerNotelp.text, kode);
                              if (await sendSMS == true) {
                                // ignore: use_build_context_synchronously
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Berhasil Mengirim Pesan',
                                  onConfirmBtnTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmPassword(),
                                        ));
                                  },
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: 'Gagal mengirim pesan',
                                );
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: 'No Hp tidak terdaftar',
                              );
                            }
                          }
                        },
                        child: Text(
                          'Kirim',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Text textWhite({required String teks, required double size}) => Text(
      teks,
      style: TextStyle(color: Colors.white, fontSize: size),
    );
