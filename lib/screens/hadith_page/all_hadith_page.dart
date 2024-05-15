import 'package:assalam/data/models/hadith/all_hadith_data_model.dart';
import 'package:assalam/data/services/hadith/get_all_hadith_data.dart';
import 'package:assalam/screens/hadith_page/hadith_section_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../settings_page/language_controller.dart';


class AllHadithPage extends StatefulWidget {
  const AllHadithPage({super.key});

  @override
  State<AllHadithPage> createState() => _AllHadithPageState();
}

class _AllHadithPageState extends State<AllHadithPage> {
  //
  final fetchAllHadith = GetAllHadithData();
  final translator = GoogleTranslator();
  late String targetLanguage;

  @override
  void initState() {
    _updateTargetLanguage();
    fetchAllHadith.fetchAllHadithData();
    super.initState();
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
  Widget build(BuildContext context) {
    //
    AllHadithDataModel allHadithDataModel;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [

              FutureBuilder<AllHadithDataModel>(
                future: fetchAllHadith.fetchAllHadithData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show a loading indicator while fetching data
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    allHadithDataModel = snapshot.data!;

                    return Column(
                      children: [

                        for (final allHadith in allHadithDataModel.books!)
                          Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: ListTile(
                                title: FutureBuilder<Translation>(
                                  future: translator.translate(allHadith.hadisName, from: 'auto', to: targetLanguage),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final translatedText = snapshot.data!.text;
                                      return Text(translatedText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                                leading: FutureBuilder<Translation>(
                                  future: translator.translate(allHadith.id.toString(), from: 'auto', to: targetLanguage),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final translatedText = snapshot.data!.text;
                                      return Text(translatedText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                                // title: Text(allHadith.hadisName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                                // leading: Text(allHadith.id.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                                trailing: Icon(Icons.arrow_forward_ios, size: 20),
                                 onTap: () => Get.to(HadithSectionPage(hadithId: allHadith.id, hadithName: allHadith.hadisName, hadithApi: allHadith.fileApi)),
                              ),

                            ),
                          ),

                      ],
                    );

                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
