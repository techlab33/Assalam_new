import 'package:assalam/data/models/quran_model/quran_data_model.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';


class ShowQuranPage extends StatelessWidget {
  ShowQuranPage({
    super.key,
    required this.suraID,
    required this.suraName,
    required this.quranDataModel,
  });

  String suraName;
  QuranDataModel quranDataModel;
  String suraID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(suraName, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              for (final quran in quranDataModel.data!.surahs)
                for (final ayahs in quran.ayahs.where((element) => element.numberInSurah.toString() == suraID))
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
                      child: Column(
                        children: [
                          Text(ayahs.text, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500), textAlign: TextAlign.right),
                          SizedBox(height: 15),
                          Text(ayahs.englishTexTranslation, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic)),
                          SizedBox(height: 10),
                          // Text(sura.ayatDescription, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal)),
                          Row(
                            children: [
                              Text(suraID + '.' + ayahs.number.toString()),

                              SizedBox(width: 80),

                              IconButton(
                                padding:EdgeInsets.zero,
                                onPressed: () {},
                                icon: Icon(Icons.play_circle_outline , size: 24),
                              ),
                              IconButton(
                                padding:EdgeInsets.zero,
                                onPressed: () {
                                  FlutterClipboard.copy('${ayahs.text}\n' + '${ayahs.englishTexTranslation}');
                                  Get.snackbar('Copy!', '${ayahs.text}\n' + '${ayahs.englishTexTranslation}' ,backgroundColor: Colors.green.shade400, colorText: Colors.white, duration: Duration(seconds: 2));
                                },
                                icon: Icon(Icons.copy , size: 24),
                              ),
                              IconButton(
                                padding:EdgeInsets.zero,
                                onPressed: ()  {},
                                icon: Icon(Icons.share , size: 24),
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
