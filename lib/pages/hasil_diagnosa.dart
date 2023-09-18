import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pendeteksi_kerusakan_mangga/controller/kerusakan_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../layout/timer.dart';

// ignore: must_be_immutable
class HasilDiagnosa extends StatefulWidget {
  List<String>? gejala;
  HasilDiagnosa({this.gejala, super.key});

  @override
  State<HasilDiagnosa> createState() => _HasilDiagnosaState(gejala);
}

class _HasilDiagnosaState extends TimeoutMixin<HasilDiagnosa> {
  List<String>? gejala;
  YoutubePlayerController? _controller;
  int? id;

  _HasilDiagnosaState(this.gejala);

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(226, 226, 226, 1),
        appBar: AppBar(
          title: Text('Diagnosa'),
          backgroundColor: Color.fromRGBO(11, 166, 8, 1),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            resetTimer();
          },
          child: FutureBuilder<Map<String, dynamic>?>(
            future: KerusakanController().getHasilDiagnosa(gejala!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      size: 80,
                    ),
                    Text('Tidak ada koneksi internet '),
                  ],
                );
              } else if (snapshot.hasData) {
                return FutureBuilder(
                  future: KerusakanController()
                      .getKerusakanById(snapshot.data!['id'].toString()),
                  builder: (context, snap) {
                    String? url = snap.data?.url;
                    if (url != null) {
                      final videoID =
                          YoutubePlayer.convertUrlToId(snap.data!.url!);
                      _controller = YoutubePlayerController(
                          initialVideoId: videoID!,
                          flags: YoutubePlayerFlags(autoPlay: false));
                    }
                    double pemb_kemiripan = double.parse(
                        snapshot.data!['kemiripan'].toStringAsFixed(2));
                    String percen_kemiripan =
                        (pemb_kemiripan * 100).toStringAsFixed(2) + '%';
                    if (snap.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                                delegate: SliverChildListDelegate([
                              Card(
                                child: Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hasil Diagnosa : ${snapshot.data!['nama']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Kemiripan : ${percen_kemiripan}',
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ])),
                            SliverList(
                                delegate: SliverChildListDelegate([
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  resetTimer();
                                },
                                child: Card(
                                  margin: EdgeInsets.only(top: 30),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0)
                                        .copyWith(top: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snap.data!.nama ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CachedNetworkImage(
                                          imageUrl: snap.data!.img ?? '',
                                          height: 300,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          snap.data!.deskripsi ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            height: 1.4,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Gejala Serangan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        ListView.builder(
                                          itemCount: snap.data!.gejala!.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return content(
                                                toBeginningOfSentenceCase(snap
                                                        .data!
                                                        .gejala![index]
                                                        .nama) ??
                                                    '');
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Cara Penanganan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        ListView.builder(
                                          itemCount:
                                              snap.data!.penanganan!.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return content(
                                                toBeginningOfSentenceCase(snap
                                                        .data!
                                                        .penanganan![index]
                                                        .nama) ??
                                                    '');
                                          },
                                        ),
                                        const SizedBox(
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
                                                showVideoProgressIndicator:
                                                    true,
                                              )
                                            : Center(),
                                        _controller != null
                                            ? Text(
                                                'source: $url',
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
                                ),
                              ),
                            ]))
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              }
              return const Center(
                child: Text('Sedang melakukan Diagnosa'),
              );
            },
          ),
        ));
  }

  Widget listSolution({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 7, left: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 13, top: 5),
            height: 10.0,
            width: 10.0,
            decoration: new BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
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
