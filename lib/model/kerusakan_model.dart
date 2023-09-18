class Kerusakan {
  int? id;
  String? nama;
  String? morfologi;
  String? jenis;
  List<dynamic>? gejala;
  List<dynamic>? penanganan;
  String? url;
  String? img;
  String? deskripsi;

  Kerusakan.name(Map<String, dynamic> parsedJson) {
    id = parsedJson['id_kerusakan'];
    nama = parsedJson['nama'];
  }
  Kerusakan.fromJason(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    nama = parsedJson['nama'];
    jenis = parsedJson['jenis'];
    url = parsedJson['url'];
    img = parsedJson['img'];
    gejala = parsedJson['gejala'].map((e) => Gejala.fromJason(e)).toList();
    penanganan =
        parsedJson['penanganan'].map((e) => Penanganan.fromJason(e)).toList();
    deskripsi = parsedJson['deskripsi'];
    if (parsedJson['morfologi'] != null) {
      morfologi = parsedJson['morfologi'];
    }
  }
}

class Gejala {
  int? id;
  String? nama;
  String? url;
  Gejala.fromJason(Map<String, dynamic> parsedJson) {
    nama = parsedJson['nama'];
  }

  Gejala.withId(Map<String, dynamic> parsedJson) {
    id = parsedJson['id_gejala'];
    nama = parsedJson['nama'];
    url = parsedJson['url'];
  }
}

class Penanganan {
  String? nama;
  Penanganan.fromJason(Map<String, dynamic> parsedJson) {
    nama = parsedJson['nama'];
  }
}

class JenisSerangan {
  String? nama;
  List<dynamic>? gejala;
  JenisSerangan.withGejala(Map<String, dynamic> parsedJson) {
    nama = parsedJson['nama'];
    gejala = parsedJson['gejala'].map((e) => Gejala.withId(e)).toList();
  }
}
