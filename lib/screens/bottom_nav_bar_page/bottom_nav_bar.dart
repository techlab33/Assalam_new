import 'package:assalam/screens/home_page/home_page.dart';
import 'package:assalam/screens/prayer_page/prayer_page.dart';
import 'package:assalam/screens/quran_page/quran_page.dart';
import 'package:assalam/screens/settings_page/settings_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
// class BottomNaveBarPage extends StatefulWidget {
//   const BottomNaveBarPage({super.key});
//
//   @override
//   State<BottomNaveBarPage> createState() => _BottomNaveBarPageState();
// }
//
// class _BottomNaveBarPageState extends State<BottomNaveBarPage> {
//   var bottomIndex = 0;
//   List bottomNavigation = [
//     {'image': 'assets/icons/home.png', 'title': 'Home'},
//     {'image': 'assets/icons/prayer.png', 'title': 'Prayer'},
//     {'image': 'assets/icons/islam.png', 'title': 'Qibla'},
//     {'image': 'assets/icons/quran.png', 'title': 'Quran'},
//     {'image': 'assets/icons/setting.png', 'title': 'Setting'}
//   ];
//
//   List page = [
//     const HomePage(),
//     const PrayerPage(),
//     const QuranPage(),
//     const QiblaPage(),
//     const SettingsPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//       bottomNavigationBar: SizedBox(
//         height: screenSize.height / 11,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             for (var i= 0; i < bottomNavigation.length; i++)
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     bottomIndex = i;
//                   });
//                 },
//                 child: Container(
//                   width: 65,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(height: screenSize.height / 78.8),
//                       Image.asset(bottomNavigation[i]['image'], height: screenSize.height / 28.14, width: screenSize.height / 28.14, color: bottomIndex == i ? Colors.green : Colors.black87,),
//                       const SizedBox(height: 5),
//                       Text(
//                         '${bottomNavigation[i]['title']}',
//                         style: TextStyle(color: bottomIndex == i ? Colors.green : Colors.black87, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 500),
//         child: page[bottomIndex],
//       ),
//     );
//   }
// }

class BottomNaveBarPage extends StatefulWidget {
  const BottomNaveBarPage({super.key});

  @override
  State<BottomNaveBarPage> createState() => _BottomNaveBarPageState();
}

class _BottomNaveBarPageState extends State<BottomNaveBarPage> {

  var navbarIndex = 0;
  List page = [
    const HomePage(),
     PrayerPage(),
    const QuranPage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        onTap: (value) {
          setState(() {
            navbarIndex = value;
          });
        },
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        color: Color(0xF3044204),
        animationDuration: const Duration(milliseconds: 300),
        items: [
          Image.asset('assets/icons/home.png',height: screenSize.height / 32, width: screenSize.height / 28.14, color: Colors.white),
          Image.asset('assets/icons/prayer.png',height: screenSize.height / 30, width: screenSize.height / 28.14, color: Colors.white),
          Image.asset('assets/icons/quran.png',height: screenSize.height / 30, width: screenSize.height / 28.14, color: Colors.white),
          Image.asset('assets/icons/setting.png',height: screenSize.height / 30, width: screenSize.height / 28.14, color: Colors.white),
        ],
      ),
    body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: page[navbarIndex],
    ),
    );
  }
}

