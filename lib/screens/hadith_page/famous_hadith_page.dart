
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../../data/models/hadith/famous_hadith_data_model.dart';
import '../../data/services/hadith/get_famous_hadith_data.dart';
import '../settings_page/language_controller.dart';

class FamousHadithPage extends StatefulWidget {
  const FamousHadithPage({Key? key}) : super(key: key);

  @override
  State<FamousHadithPage> createState() => _FamousHadithPageState();
}

class _FamousHadithPageState extends State<FamousHadithPage> {
  final fetchFamousHadith = GetAllFamousHadith();
  final translator = GoogleTranslator();
  late String targetLanguage;
  late Future<FamousHadithDataModel?> _famousHadithFuture;

  @override
  void initState() {
    super.initState();
    _updateTargetLanguage();
  }

  void _updateTargetLanguage() {
    final languageController = Get.put(LanguageController());
    targetLanguage = languageController.language;
    languageController.languageStream.listen((language) {
      setState(() {
        targetLanguage = language;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _famousHadithFuture = fetchFamousHadith.fetchAllFamousHadithData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: FutureBuilder<FamousHadithDataModel?>(
            future: _famousHadithFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                final famousHadithDataModel = snapshot.data;
                if (famousHadithDataModel == null || famousHadithDataModel.hadises == null || famousHadithDataModel.hadises!.isEmpty) {
                  return Center(
                    child: Text('No famous hadith data available.'),
                  );
                }
                return Column(
                  children: [
                    for (final hadith in famousHadithDataModel.hadises!)
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              Text(hadith.hadis, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic), textAlign: TextAlign.right),
                              SizedBox(height: 5),
                              FutureBuilder<Translation>(
                                future: translator.translate(hadith.hadisTranslate, from: 'auto', to: targetLanguage),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final translatedText = snapshot.data!.text;
                                    return Text(translatedText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.right);
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                              FutureBuilder<Translation>(
                                future: translator.translate(hadith.hadisDescription, from: 'auto', to: targetLanguage ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final translatedText = snapshot.data!.text;
                                    return Text(translatedText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal));
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: FutureBuilder<Translation>(
                                  future: translator.translate(hadith.reference, from: 'auto', to: targetLanguage ),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final translatedText = snapshot.data!.text;
                                      return Text(translatedText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal), textAlign: TextAlign.left);
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

