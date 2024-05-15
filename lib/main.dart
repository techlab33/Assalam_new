import 'package:assalam/controller/auth_controller/login_controller.dart';
import 'package:assalam/screens/authentication/registration_page/registration_page.dart';
import 'package:assalam/screens/bottom_nav_bar_page/bottom_nav_bar.dart';
import 'package:assalam/screens/settings_page/language_controller.dart';
import 'package:assalam/utils/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application widgets for.

  final loginController = Get.put(LoginController());

  @override
  void initState() {

    loginController.isUserLogin().then((value) => {

      if(value == true){
        Get.offAll(const BottomNaveBarPage()),
      }else  {
        Get.offAll(const RegistrationPage()),
      }

    });

    //
    final languageController = Get.put(LanguageController());

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appThemes,
      home: const RegistrationPage(),
    );

  }
}
