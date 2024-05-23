

import 'dart:developer';
import 'package:assalam/data/models/quran_model/quran_data_model.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class ShowQuranPage extends StatefulWidget {
  ShowQuranPage({
    super.key,
    required this.suraId,
    required this.suraName,
    required this.quranDataModel,
  });

  final String suraName;
  final QuranDataModel quranDataModel;
  final String suraId;

  @override
  State<ShowQuranPage> createState() => _ShowQuranPageState();
}

class _ShowQuranPageState extends State<ShowQuranPage> {
  final _player = AudioPlayer();
  bool _isPlaying = false;
  String _currentlyPlayingUrl = '';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer();
  }

  // Set Audio Player
  Future<void> _setupAudioPlayer() async {
    _player.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _currentlyPlayingUrl = '';
        });
      }
    }, onError: (Object e, StackTrace stackTrace) {
      log('A stream error occurred: $e');
    });
  }

  Future<void> _playAudio(String url) async {
    try {
      if (_currentlyPlayingUrl == url && _isPlaying) {
        await _player.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await _player.stop();
        await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
        _player.play();
        setState(() {
          _isPlaying = true;
          _currentlyPlayingUrl = url;
        });
      }
    } catch (e) {
      log('Error loading audio source: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.suraName,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final quran in widget.quranDataModel.data!.surahs)
                for (final ayahs in quran.ayahs.where((element) => quran.number.toString() == widget.suraId))
                  Card(
                    elevation: 3,
                    shadowColor: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
                      child: Column(
                        children: [
                          Text(
                            ayahs.text,
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(height: 15),
                          Text(
                            ayahs.englishTexTranslation,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('${widget.suraId}.${ayahs.numberInSurah}'),
                              SizedBox(width: 80),
                              IconButton(
                                icon: Icon(
                                  _currentlyPlayingUrl == ayahs.audio && _isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 38,
                                ),
                                onPressed: () => _playAudio(ayahs.audio),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  FlutterClipboard.copy('${ayahs.text}\n${ayahs.englishTexTranslation}');
                                  Get.snackbar(
                                    'Copy!',
                                    '${ayahs.text}\n${ayahs.englishTexTranslation}',
                                    backgroundColor: Colors.green.shade400,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2),
                                  );
                                },
                                icon: Icon(Icons.copy, size: 24),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  log(ayahs.audio);
                                },
                                icon: Icon(Icons.share, size: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}






