import 'package:assalam/screens/settings_page/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class DuaContainerCard extends StatefulWidget {
  DuaContainerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onPressed,
  });

  String title;
  String subtitle;
  Color color;
  void Function()? onPressed;

  @override
  State<DuaContainerCard> createState() => _DuaContainerCardState();
}

class _DuaContainerCardState extends State<DuaContainerCard> {

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
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Translation>(
              future: translator.translate(widget.title, from: 'auto', to: targetLanguage),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final translatedText = snapshot.data!.text;
                  return Text(translatedText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SizedBox();
                }
              },
            ),
            FutureBuilder<Translation>(
              future: translator.translate('${widget.subtitle} Chapters', from: 'auto', to: targetLanguage),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final translatedText = snapshot.data!.text;
                  return Text(translatedText, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SizedBox();
                }
              },
            ),
            // Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            // Text('${widget.subtitle} Chapters', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

