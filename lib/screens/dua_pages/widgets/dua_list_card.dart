import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../../settings_page/language_controller.dart';
class DuaListCard extends StatefulWidget {
  DuaListCard({
    super.key,
    required this.number,
    required this.text,
    this.onPressed,
  });

  String number;
  String text;
  void Function()? onPressed;

  @override
  State<DuaListCard> createState() => _DuaListCardState();
}

class _DuaListCardState extends State<DuaListCard> {

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
    return Card(
      child: ListTile(
        onTap: widget.onPressed,
        leading: FutureBuilder<Translation>(
          future: translator.translate('${widget.number}.', from: 'auto', to: targetLanguage),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final translatedText = snapshot.data!.text;
              return Text(translatedText, style: TextStyle(fontSize: 16, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SizedBox();
            }
          },
        ),
        title: FutureBuilder<Translation>(
          future: translator.translate(widget.text, from: 'auto', to: targetLanguage),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final translatedText = snapshot.data!.text;
              return Text(translatedText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black87));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SizedBox();
            }
          },
        ),
        // leading: Text('${widget.number}.', style: TextStyle(fontSize: 16, color: Colors.green)),
         // title: Text(widget.text, style: TextStyle(fontSize: 16, color: Colors.green), maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}