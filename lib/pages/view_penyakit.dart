import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/detail_penyakit.dart';

import '../controller/kerusakan_controller.dart';
import '../layout/timer.dart';

// ignore: must_be_immutable
class ViewPenyakit extends StatefulWidget {
  const ViewPenyakit({super.key});

  @override
  State<ViewPenyakit> createState() => _ViewPenyakitState();
}

class _ViewPenyakitState extends TimeoutMixin<ViewPenyakit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226, 1),
      appBar: AppBar(
        title: Text(
          'Penyakit',
        ),
        backgroundColor: Color.fromRGBO(11, 166, 8, 1),
      ),
      body: FutureBuilder<List?>(
        future: KerusakanController().getPenyakit(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.warning_amber_outlined,
                    size: 80,
                  ),
                ),
                Text('Tidak ada koneksi internet '),
              ],
            );
          } else if (snapshot.hasData) {
            return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  resetTimer();
                },
                child: listView(snapshot));
          }
          return const Center(child: Text('Tunggu Sebentar.....'));
        },
      ),
    );
  }
}

ListView listView(AsyncSnapshot<List<dynamic>?> snapshot) {
  return ListView.builder(
    padding: EdgeInsets.all(40),
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPenyakit(snapshot.data![index].id),
                ));
          },
          style: const ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
          ),
          child: Text(
            snapshot.data![index].nama,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 15),
          ),
        ),
      );
    },
  );
}
