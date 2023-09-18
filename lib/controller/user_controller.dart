import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  String baseurl = "http://10.0.2.2:8000";
  bool auth = false;

  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static Future<GoogleSignInAccount?> handleSignIn() async {
    try {
      return await googleSignIn.signIn();
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool?> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token') || pref.containsKey('email')) {
      return true;
    }
    return false;
  }

  Future<Map?> login(String nama, String pass) async {
    Uri url = Uri.parse('$baseurl/api/user/l');
    final pref = await SharedPreferences.getInstance();
    http.Response result = await http.post(url, body: {
      'nama': nama,
      'password': pass
    }, headers: {
      'Accept': 'application/json',
    });

    if (result.statusCode == HttpStatus.ok) {
      print('sukses');
      final jsonResponse = jsonDecode(result.body);
      pref.setString('nama', jsonResponse['nama']);
      pref.setString('token', jsonResponse['token']);
      return jsonResponse;
    } else {
      print('gagal');
      return null;
    }
  }

  Future<Map?> loginGoogle(String email, String nama, String id) async {
    Uri url = Uri.parse('$baseurl/api/user/lg');
    print(nama + email + id);
    final pref = await SharedPreferences.getInstance();
    http.Response result = await http.post(url, body: {
      'id': id,
      'nama': nama,
      'email': email
    }, headers: {
      'Accept': 'application/json',
    });

    if (result.statusCode == HttpStatus.ok) {
      print('sukses');
      final jsonResponse = jsonDecode(result.body);
      pref.setString('email', email);
      pref.setString('nama', nama);
      return jsonResponse;
    } else {
      print('gagal');
      return null;
    }
  }

  Future<Map?> register(
    String nama,
    String notelp,
    String pass,
    String confirmpass,
  ) async {
    Uri url = Uri.parse('$baseurl/api/user/r');
    http.Response result = await http.post(url, body: {
      'nama': nama,
      'notelp': notelp,
      'password': pass,
      'password_confirmation': confirmpass
    }, headers: {
      'Accept': 'application/json',
    });

    final jsonResponse = jsonDecode(result.body);
    if (result.statusCode == HttpStatus.ok) {
      print('sukses');
      return jsonResponse;
    } else {
      print('gagal');
      return jsonResponse;
    }
  }

  Future<Map<String, dynamic>?> getUser(String notelp) async {
    final url = Uri.parse('$baseurl/api/user/v');
    http.Response response = await http.post(url, body: {
      'notelp': notelp,
    }, headers: {
      'Accept': 'application/json',
    });
    final result = jsonDecode(response.body);
    Map<String, dynamic>? data = result['data'];
    if (response.statusCode == HttpStatus.ok) {
      print('sukses');
      return data;
    } else {
      print('gagal');
      return null;
    }
  }

  Future<void> changePass(String? id, String pass) async {
    final url = Uri.parse('$baseurl/api/user/u');
    http.Response response = await http.post(url, body: {
      'id': id,
      'newPass': pass
    }, headers: {
      'Accept': 'application/json',
    });
    if (response.statusCode == HttpStatus.ok) {
      print('sukses');
    } else {
      print('gagal');
    }
  }

  Future<bool> sendSMS(String phone, String kode) async {
    final url = Uri.parse('$baseurl/api/sms/s');
    if (phone.startsWith('0')) {
      phone = phone.replaceFirst('0', '+62');
    }
    http.Response response = await http.post(url, body: {
      'phone': phone,
      'kode': kode
    }, headers: {
      'Accept': 'application/json',
    });
    if (response.statusCode == HttpStatus.ok) {
      print('sukses');
      return true;
    } else {
      print('gagal');
      return false;
    }
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token')) {
      Uri url = Uri.parse('$baseurl/api/logout');
      await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}'
      });
    } else {
      // await pref.clear();
      if (await googleSignIn.isSignedIn()) {
        googleSignIn.disconnect();
      }
    }
    await pref.clear();
  }
}
