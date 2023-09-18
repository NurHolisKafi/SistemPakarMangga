import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/controller/user_controller.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/login.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../layout/input_form.dart';

// ignore: must_be_immutable
class ConfirmPassword extends StatelessWidget {
  ConfirmPassword({super.key});
  final _key = GlobalKey<FormFieldState<String>>();
  TextEditingController controllerKode = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();

  Future<void> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('user_id')) {
      print(pref.get('user_id'));
      print(pref.get('kode'));
    } else {
      print('gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    isLogin();
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
                    textWhite(
                        teks: "Masukkan kode pada sms yang dikirim", size: 13),
                    SizedBox(height: 15),
                    inputFrom(
                        hint: 'KODE',
                        msg: 'Kode Tidak Boleh Kosong',
                        controller: controllerKode),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: controllerNewPassword,
                      enableSuggestions: true,
                      obscureText: true,
                      autocorrect: false,
                      style: TextStyle(fontSize: 16),
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 17, bottom: 17),
                          hintText: 'PASSWORD BARU',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(163, 156, 156, 1),
                              fontSize: 12),
                          // ignore: prefer_const_constructors
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                      validator: (value) {
                        RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,16}$');
                        bool isValid = regex.hasMatch(value.toString());
                        if (value == null || value.isEmpty) {
                          return 'Password Tidak Boleh Kosong';
                        } else if (!isValid) {
                          return '''Password minimal terdiri dari 8-16 karakter,
1 huruf besar, dan 1 angka''';
                        }
                        return null;
                      },
                    ),
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
                          final pref = await SharedPreferences.getInstance();
                          if (valid) {
                            if (controllerKode.text == pref.get('kode')) {
                              await UserController().changePass(
                                  pref.getString('user_id'),
                                  controllerNewPassword.text);
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Berhasil merubah password',
                                onConfirmBtnTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ));
                                },
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: 'Kode yang dimasukkan salah',
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
