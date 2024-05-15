import 'package:flutter/material.dart';
import 'package:assalam/data/models/hadith/hadith_book_data_model.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../settings_page/language_controller.dart';

class AllHadithShowPage extends StatefulWidget {
  final String sectionName;
  final String sectionKey;
  final int hadithFirstNumber;
  final int hadithLastNumber;
  final HadithBookDataModel hadithBookDataModel;

  AllHadithShowPage({
    super.key,
    required this.sectionName,
    required this.sectionKey,
    required this.hadithFirstNumber,
    required this.hadithLastNumber,
    required this.hadithBookDataModel,
  });

  @override
  State<AllHadithShowPage> createState() => _AllHadithShowPageState();
}

class _AllHadithShowPageState extends State<AllHadithShowPage> {

  final translator = GoogleTranslator();
  late String targetLanguage;

  @override
  void initState() {
    _updateTargetLanguage();
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
    final hadiths = widget.hadithBookDataModel.hadiths ?? []; // Ensure the list is not null

    // Filter hadiths to only include those within the given range
    final filteredHadith = hadiths.where((hadith) => hadith.hadithnumber >= widget.hadithFirstNumber && hadith.hadithnumber <= widget.hadithLastNumber).toList(); // Make sure to convert back to list

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Translation>(
          future: translator.translate(widget.sectionName, from: 'auto', to: targetLanguage),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final translatedText = snapshot.data!.text;
              return Text(translatedText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SizedBox();
            }
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: filteredHadith.isEmpty
            ? Center(child: Text('No hadiths in this Book'))
            : ListView.builder(
          itemCount: filteredHadith.length,
          itemBuilder: (context, index) {
            final hadith = filteredHadith[index]; // Access filtered hadith

            return Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<Translation>(
                      future: translator.translate('Hadith No. ${hadith.hadithnumber.toString()}', from: 'auto', to: targetLanguage),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final translatedText = snapshot.data!.text;
                          return Text(translatedText,  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500), textAlign: TextAlign.right);
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return SizedBox();
                        }
                      },
                    ),

                    const SizedBox(height: 15), // Adding some spacing
                    Text(hadith.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),textAlign: TextAlign.right,),
                    const SizedBox(height: 15), // More spacing
                    FutureBuilder<Translation>(
                      future: translator.translate(hadith.text, from: 'auto', to: targetLanguage),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final translatedText = snapshot.data!.text;
                          return Text(translatedText,  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),

                    const SizedBox(height: 15),
                    Text('Book - ${hadith.reference.book.toString()}',style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
