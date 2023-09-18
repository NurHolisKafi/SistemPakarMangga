import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:pendeteksi_kerusakan_mangga/model/kerusakan_model.dart';

class KerusakanController {
  String Baseurl = "http://pakarmangga.fun/api";

  Future<List?> getHama() async {
    String url = '$Baseurl/hama/v';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      print('sukses');
      final jsonResponse = jsonDecode(result.body);
      List hama = jsonResponse.map((i) => Kerusakan.name(i)).toList();
      return hama;
    } else {
      print('false');
      return null;
    }
  }

  Future<List?> getPenyakit() async {
    String url = '$Baseurl/penyakit/v';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      print('sukses');
      final jsonResponse = jsonDecode(result.body);
      List penyakit = jsonResponse.map((i) => Kerusakan.name(i)).toList();
      return penyakit;
    } else {
      print('false');
      return null;
    }
  }

  Future<List?> getJenisSerangan() async {
    String url = '$Baseurl/js/v';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      print('sukses');
      final jsonResponse = jsonDecode(result.body);
      List serangan =
          jsonResponse.map((i) => JenisSerangan.withGejala(i)).toList();
      return serangan;
    } else {
      print('false');
      return null;
    }
  }

  Future<Kerusakan?> getKerusakanById(String id) async {
    String url = '$Baseurl/kerusakan/v/$id';
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      print('sukses');
      final jsonResponse = jsonDecode(result.body);
      List kerusakan = jsonResponse.map((i) => Kerusakan.fromJason(i)).toList();
      return kerusakan[0];
    } else {
      print('false');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getHasilDiagnosa(List<String> gejala) async {
    String url = '$Baseurl/diagnosa';
    String listGejala = gejala.join('| ');
    print(listGejala);
    http.Response result = await http.post(Uri.parse(url), body: {
      'gejala': listGejala
    }, headers: {
      'Accept': 'application/json',
    });

    if (result.statusCode == HttpStatus.ok) {
      // print('sukses');
      final jsonResponse = jsonDecode(result.body);
      return jsonResponse;
    } else {
      print('false');
      return null;
    }
  }
}
