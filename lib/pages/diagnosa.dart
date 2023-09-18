import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/controller/kerusakan_controller.dart';
import 'package:pendeteksi_kerusakan_mangga/layout/sidebar.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/hasil_diagnosa.dart';

import '../layout/timer.dart';

// ignore: must_be_immutable
class Diagnosa extends StatefulWidget {
  Diagnosa({super.key});

  @override
  State<Diagnosa> createState() => _DiagnosaState();
}

class _DiagnosaState extends TimeoutMixin<Diagnosa> {
  late List<List<bool>> checkboxStates;
  late AsyncSnapshot<List?> snap;
  @override
  void initState() {
    checkboxStates = [];
    super.initState();
  }

  List<String> getCheckedCheckboxes(AsyncSnapshot<List?> snapshot) {
    List<String> checkedItems = [];

    for (int i = 0; i < checkboxStates.length; i++) {
      for (int j = 0; j < checkboxStates[i].length; j++) {
        if (checkboxStates[i][j]) {
          checkedItems.add(snapshot.data![i].gejala[j].nama);
        }
      }
    }

    return checkedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226, 1),
      appBar: AppBar(
        title: Text('Diagnosa'),
        backgroundColor: Color.fromRGBO(11, 166, 8, 1),
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        // physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(left: 20, top: 50, right: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('PILIH GEJALA KERUSAKAN YANG SESUAI '),
                const Text('DENGAN KONDISI TANAMAN ANDA'),
                const SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            sliver: FutureBuilder<List?>(
              future: KerusakanController().getJenisSerangan(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber_outlined,
                          size: 80,
                        ),
                        Text('Tidak ada koneksi internet '),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  snap = snapshot;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= checkboxStates.length) {
                          checkboxStates
                              .add([]); // Membuat objek CheckBoxState baru
                        }
                        return Card(
                          child: ExpansionTile(
                            title: Text(snapshot.data?[index].nama),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data![index].gejala.length,
                                itemBuilder: (context, i) {
                                  if (i >= checkboxStates[index].length) {
                                    checkboxStates[index].add(false);
                                  }

                                  String gambar;
                                  if (snapshot.data![index].gejala[i].url ==
                                      "") {
                                    gambar =
                                        'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png';
                                  } else {
                                    gambar =
                                        snapshot.data![index].gejala[i].url;
                                  }

                                  String nama =
                                      snapshot.data![index].gejala[i].nama;
                                  return CheckboxListTile(
                                    contentPadding: EdgeInsets.all(10),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Apakah $nama ?',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: const Text(
                                                            'Contoh Gambar'),
                                                        titleTextStyle:
                                                            const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                        content: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          child: Image.network(
                                                            gambar,
                                                            height: 200,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(20),
                                                      ));
                                            },
                                            child: Text(
                                              'lihat gambar',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    value: checkboxStates[index][i],
                                    onChanged: (value) {
                                      resetTimer();
                                      setState(() {
                                        checkboxStates[index][i] = value!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  );
                }
                return const SliverFillRemaining(
                  child: Center(child: Text('Tunggu Sebentar.....')),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(36, 223, 36, 1),
        child: Icon(Icons.check),
        onPressed: () {
          final gejala = getCheckedCheckboxes(snap);
          if (gejala.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gejala Tidak Boleh Kosong')));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HasilDiagnosa(
                    gejala: gejala,
                  ),
                ));
          }
        },
      ),
    );
  }
}
