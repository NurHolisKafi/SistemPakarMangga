import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pendeteksi_kerusakan_mangga/layout/input_form.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/login.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../controller/user_controller.dart';

// import 'package:pendeteksi_kerusakan_mangga/pages/login.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  GoogleSignIn? signIn;
  Register({this.signIn, super.key});

  @override
  State<Register> createState() => _RegisterState(signIn);
}

class _RegisterState extends State<Register> {
  GoogleSignIn? signIn;
  _RegisterState(this.signIn);

  final _key = GlobalKey<FormFieldState<String>>();
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerNotelp = TextEditingController();
  TextEditingController controllerConfirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Background.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _key,
          child: Center(
            child: Container(
              height: height,
              padding: EdgeInsets.only(
                top: 110,
              ),
              width: width * 0.75,
              child: ListView(
                children: [
                  textWhite(teks: "SIGN UP", size: 35),
                  SizedBox(height: 40),
                  inputFrom(
                      hint: 'USERNAME',
                      msg: 'Username Tidak Boleh Kosong',
                      controller: controllerNama),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerNotelp,
                    autocorrect: false,
                    style: TextStyle(fontSize: 16),
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 17, bottom: 17),
                        hintText: 'NO HP',
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(163, 156, 156, 1),
                            fontSize: 12),
                        // ignore: prefer_const_constructors
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.transparent))),
                    validator: (value) {
                      RegExp regex = RegExp(r'^\d{12,}$');
                      bool isValid = regex.hasMatch(value.toString());
                      if (value == null || value.isEmpty) {
                        return 'No Hp Tidak Boleh Kosong';
                      } else if (!isValid) {
                        return 'No hp minimal 12 angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerPass,
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
                        hintText: 'PASSWORD',
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(163, 156, 156, 1),
                            fontSize: 12),
                        // ignore: prefer_const_constructors
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.transparent))),
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
                  const SizedBox(
                    height: 20,
                  ),
                  inputFromPassword(
                      hint: 'KONFIRMASI PASSWORD',
                      msg: 'Konfirmasi Password Tidak Boleh Kosong',
                      controller: controllerConfirmPass),
                  const SizedBox(
                    height: 35,
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                        minimumSize: MaterialStatePropertyAll(Size(253, 50)),
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(73, 88, 103, 1)),
                      ),
                      onPressed: () async {
                        final valid = Form.of(context).validate();
                        if (valid) {
                          final result = await UserController().register(
                              controllerNama.text,
                              controllerNotelp.text,
                              controllerPass.text,
                              controllerConfirmPass.text);
                          if (result!['success'] == true) {
                            // ignore: use_build_context_synchronously
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Register Berhasil',
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
                            List error = result['errors'].values.toList();
                            List msg = error.map((e) => e[0]).toList();
                            String allMsg = msg.join(",");

                            // ignore: use_build_context_synchronously
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Gagal Register',
                                text: allMsg);
                          }
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 35,
                  ),
                  Center(child: textWhite(teks: 'OR', size: 15)),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textWhite(teks: 'Sudah Punya Akun ? ', size: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text textWhite({required String teks, required double size}) => Text(
        teks,
        style: TextStyle(color: Colors.white, fontSize: size),
      );
}
