import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/dashboard.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/lupa_password.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/register.dart';
import 'package:quickalert/quickalert.dart';
import '../controller/user_controller.dart';
import '../layout/input_form.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormFieldState<String>>();
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  @override
  void initState() {
    // UserController.googleSignIn.disconnect();
    UserController.googleSignIn.signInSilently();
    super.initState();
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
          backgroundColor: Colors.transparent,
          body: Form(
            key: _key,
            child: Center(
              child: Container(
                height: height,
                padding: EdgeInsets.only(
                  top: 130,
                ),
                width: width * 0.75,
                child: ListView(
                  children: [
                    textWhite(teks: "SIGN IN", size: 35),
                    SizedBox(height: 40),
                    inputFrom(
                        hint: 'USERNAME',
                        msg: 'Username Tidak Boleh Kosong',
                        controller: controllerNama),
                    SizedBox(
                      height: 20,
                    ),
                    inputFromPassword(
                        hint: 'PASSWORD',
                        msg: 'Password Tidak Boleh Kosong',
                        controller: controllerPass),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LupaPassword(),
                            ));
                      },
                      child: Align(
                          alignment: Alignment.topRight,
                          child: textWhite(teks: "lupa Password ?", size: 14)),
                    ),
                    SizedBox(
                      height: 30,
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
                            final result = await UserController().login(
                                controllerNama.text, controllerPass.text);
                            if (result != null) {
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Login Berhasil',
                                onConfirmBtnTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Dashboard(),
                                      ));
                                },
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: 'Username atau Password Salah',
                              );
                            }
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    Center(child: textWhite(teks: 'OR', size: 15)),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          minimumSize:
                              MaterialStatePropertyAll(Size.fromHeight(45)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: () async {
                          final user = await UserController.handleSignIn();
                          if (user != null) {
                            final cek = await UserController().loginGoogle(
                                user.email, user.displayName ?? '', user.id);
                            // String cek = 'a';
                            if (cek != null) {
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Login Berhasil',
                                onConfirmBtnTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Dashboard(),
                                      ));
                                },
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              UserController.googleSignIn.disconnect();
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: 'Gagal Login',
                              );
                            }
                          } else {
                            print('kosong');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/Google_Logo.png',
                              width: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Sign in With Google',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWhite(teks: 'Belum Punya Akun ? ', size: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ));
                          },
                          child: Text(
                            'Sign Up',
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
        ));
  }
}

Text textWhite({required String teks, required double size}) => Text(
      teks,
      style: TextStyle(color: Colors.white, fontSize: size),
    );
