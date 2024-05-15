import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'language_controller.dart';

class LanguageSelectorPage extends StatelessWidget {


  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            buildLanguageCard(context, 'English', 'en'),
            buildLanguageCard(context, 'Arabic', 'ar'),
            buildLanguageCard(context, 'Bengali', 'bn'),
            // Add more language options as needed
          ],
        ),
      ),
    );
  }

  Widget buildLanguageCard(BuildContext context, String languageName, String languageCode) {
    return Obx(() {
      bool isSelected = languageController.language == languageCode;
      return Card(
        child: ListTile(
          title: Text(languageName, style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            languageController.setLanguage(languageCode);
          },
          trailing: isSelected
              ? Icon(Icons.radio_button_checked, color: Colors.green)
              : Icon(Icons.radio_button_unchecked),
        ),
      );
    });
  }
}
