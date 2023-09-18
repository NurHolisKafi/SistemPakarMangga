import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/controller/kerusakan_controller.dart';
import 'package:pendeteksi_kerusakan_mangga/pages/detail_hama.dart';

import '../layout/timer.dart';

// ignore: must_be_immutable
class ViewHama extends StatefulWidget {
  const ViewHama({super.key});

  @override
  State<ViewHama> createState() => _ViewHamaState();
}

class _ViewHamaState extends TimeoutMixin<ViewHama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226, 1),
      appBar: AppBar(
        title: const Text(
          'Hama',
        ),
        backgroundColor: Color.fromRGBO(11, 166, 8, 1),
      ),
      body: FutureBuilder<List?>(
        future: KerusakanController().getHama(),
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
                    builder: (context) => DetailHama(snapshot.data![index].id),
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
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}
