
import 'package:assalam/screens/authentication/log_in_page/login_page.dart';
import 'package:assalam/screens/profile_page/edit_profile.dart';
import 'package:assalam/screens/profile_page/profile_page.dart';
import 'package:assalam/screens/settings_page/language_selector.dart';
import 'package:assalam/screens/settings_page/widgets/custom_list_view_card.dart';
import 'package:assalam/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [

            // Profile
            CustomListViewCard(
              text: 'User Profile',
              image: 'assets/icons/user.png',
              icon: Icons.arrow_forward_ios,
              onPressed: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                final bool? isProfileComplete = prefs.getBool(AppConstraints.isProfileComplete);
                Get.to( isProfileComplete == true ? ProfilePage() : EditProfilePage());
              },
            ),
            // Premium
            CustomListViewCard(
              text: 'Premium',
              image: 'assets/icons/premium.png',
              icon: Icons.arrow_forward_ios,
              onPressed: () {},
            ),
            // Notification
            CustomListViewCard(
              text: 'Notification',
              image: 'assets/icons/notification.png',
              icon: Icons.arrow_forward_ios,
              onPressed: () {},
            ),
            // Languages
            CustomListViewCard(
              text: 'Languages',
              image: 'assets/icons/language.png',
              icon: Icons.arrow_forward_ios,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSelectorPage(),));
              },
            ),
            // Share
            CustomListViewCard(
              text: 'Share',
              image: 'assets/icons/share.png',
              icon: Icons.arrow_forward_ios,
              onPressed: () {},
            ),
            // Logout
            CustomListViewCard(
              text: 'Logout',
              image: 'assets/icons/logout.png',
              icon: Icons.arrow_forward_ios,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:const Text(
                        //'Do you want to call?'
                        'Do you want to Logout?',
                        style:  TextStyle(
                          fontFamily: 'Open_Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                logout();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),

          ],
        ),
      )),
    );
  }

  // Logout
  void logout() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    // Clear user all data
    sharedPref.clear();

    // Navigate back to the login screen
    Get.offAll( const LoginScreen());
  }
}


