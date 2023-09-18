import 'package:flutter/material.dart';
import 'package:pendeteksi_kerusakan_mangga/model/kerusakan_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:intl/intl.dart';
import '../controller/kerusakan_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../layout/timer.dart';

// ignore: must_be_immutable
class DetailPenyakit extends StatefulWidget {
  int? id;
  DetailPenyakit(this.id, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DetailPenyakit> createState() => _DetailPenyakitState(id);
}

class _DetailPenyakitState extends TimeoutMixin<DetailPenyakit> {
  YoutubePlayerController? _controller;
  int? id;
  _DetailPenyakitState(this.id);

  @override
  void initState() {
    KerusakanController().getKerusakanById(id.toString()).then((value) {
      final videoID = YoutubePlayer.convertUrlToId(value!.url ?? '');
      setState(() {
        _controller = YoutubePlayerController(
            initialVideoId: videoID!,
            flags: YoutubePlayerFlags(autoPlay: false));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226, 1),
      appBar: AppBar(
        title: Text('Penyakit'),
        backgroundColor: Color.fromRGBO(11, 166, 8, 1),
      ),
      body: FutureBuilder<Kerusakan?>(
        future: KerusakanController().getKerusakanById(id.toString()),
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
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      resetTimer();
                    },
                    child: mainPage(snapshot)),
              ),
            );
          }
          return const Center(child: Text('Tunggu Sebentar.....'));
        },
      ),
    );
  }

  Widget mainPage(AsyncSnapshot<Kerusakan?> snapshot) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(20.0).copyWith(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              snapshot.data!.nama ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
              imageUrl: snapshot.data!.img ?? '',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              snapshot.data!.deskripsi ?? '',
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Gejala Serangan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ListView.builder(
              itemCount: snapshot.data!.gejala!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return content(toBeginningOfSentenceCase(
                        snapshot.data!.gejala![index].nama) ??
                    '');
              },
            ),
            SizedBox(
              height: 15,
            ),
            _controller != null
                ? const Text(
                    'Untuk lebih jelas mengenai penangan serangan dapat dilihat video dibawah ini ',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.2,
                    ),
                  )
                : const Text(
                    '',
                  ),
            const SizedBox(
              height: 15,
            ),
            _controller != null
                ? YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                  )
                : Center(),
            _controller != null
                ? Text(
                    'source: ${snapshot.data!.url}',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.2,
                    ),
                  )
                : const Text(
                    '',
                  ),
          ],
        ),
      ),
    );
  }

  Container content(String name) {
    return Container(
        padding: const EdgeInsets.only(top: 7, left: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 13, top: 5),
              height: 10.0,
              width: 10.0,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ));
  }
}
