
import 'dart:async';
import 'dart:convert';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

import 'package:assalam/screens/dua_pages/dua_page.dart';
import 'package:assalam/screens/hadith_page/hadith_page.dart';
import 'package:assalam/screens/home_page/pages/more_page.dart';
import 'package:assalam/screens/home_page/pages/tasbih_page.dart';
import 'package:assalam/screens/home_page/widgets/gird_view_container_card.dart';
import 'package:assalam/screens/qiblah_page/qiblah_page.dart';
import 'package:assalam/screens/quran_page/quran_page.dart';
import 'package:curve_clipper/curve_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:timezone/timezone.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late final AudioPlayer audioPlayer;

  bool _isPlaying = false;

  // late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initializePlayer();

    tz.initializeTimeZones();
    _getLocation();
    _checkPermission();
    initNotifications();
    downloadJson();
  }

  Future<void> initializePlayer() async {
    audioPlayer = AudioPlayer();
    await playAudio();
  }

  Future<void> playAudio() async {
    if (!_isPlaying) {
      await audioPlayer.play(AssetSource('bismillah.mp3'));
      setState(() {
        _isPlaying = true;
      });
    }
  }

  // Future<void> initializePlayer() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   bool? audioPlayed = _prefs.getBool('audioPlayed');
  //   if (audioPlayed == null || !audioPlayed) {
  //     audioPlayer = AudioPlayer();
  //     await playAudio();
  //     _prefs.setBool('audioPlayed', true);
  //   }
  // }
  //
  // Future<void> playAudio() async {
  //   if (!_isPlaying) {
  //     await audioPlayer.play(AssetSource('bismillah.mp3'));
  //     setState(() {
  //       _isPlaying = true;
  //     });
  //   }
  // }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  bool isFinished=false;
  //===============audio end=======//

  //============notification start==========//

  List<dynamic> posts = [];
  int currentIndex = 0;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initNotifications() {


    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettings = InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> downloadJson() async {
    final response = await http.get(Uri.parse("https://raw.githubusercontent.com/techlab33/nubtk/main/new.json"));
    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
        scheduleNotification();


      });
    } else {
      throw Exception("Something went wrong while fetching data.");
    }
  }

  void scheduleNotification() {
    final scheduledTime1 = Time(4, 10, 0);//fajr
    final scheduledTime2 = Time(12, 00, 0);//dhuhr
    final scheduledTime3 = Time(15, 16, 0);//asr
    final scheduledTime4 = Time(18, 35, 0);//magrib
    final scheduledTime5 = Time(19, 45, 0);//isha


    for (int i = 0; i < posts.length; i++) {

      final now = DateTime.now();
      final scheduledDate1 = DateTime(now.year, now.month, now.day, scheduledTime1.hour, scheduledTime1.minute, scheduledTime1.second);
      final scheduledDate2 = DateTime(now.year, now.month, now.day, scheduledTime2.hour, scheduledTime2.minute, scheduledTime2.second);
      final scheduledDate3 = DateTime(now.year, now.month, now.day, scheduledTime3.hour, scheduledTime3.minute, scheduledTime3.second);
      final scheduledDate4 = DateTime(now.year, now.month, now.day, scheduledTime4.hour, scheduledTime4.minute, scheduledTime4.second);
      final scheduledDate5 = DateTime(now.year, now.month, now.day, scheduledTime5.hour, scheduledTime5.minute, scheduledTime5.second);

      if (scheduledDate1.isBefore(now)) {
        scheduledDate1.add(Duration(days: 1));
      }

      if (scheduledDate2.isBefore(now)) {
        scheduledDate2.add(Duration(days: 1));

      }
      if (scheduledDate3.isBefore(now)) {
        scheduledDate3.add(Duration(days: 1));

      }
      if (scheduledDate4.isBefore(now)) {
        scheduledDate4.add(Duration(days: 1));

      }
      if (scheduledDate5.isBefore(now)) {
        scheduledDate5.add(Duration(days: 1));

      }

      final notificationBody = posts[i]['name'] as String;
      final android = AndroidNotificationDetails(
        'scheduled_notification',
        'Scheduled Notifications',
        importance: Importance.high,
      );
      final platform = NotificationDetails(android: android);

      if (i % 2 == 0) {

        // Schedule notification for even-indexed items at 5:33 PM
        flutterLocalNotificationsPlugin.zonedSchedule(

          i, // Unique ID for the notification
          'ASSALAM', // Title
          notificationBody, // Body
          tz.TZDateTime.from(scheduledDate1, tz.local), // Scheduled time
          platform,
          androidAllowWhileIdle: true, // Allow notification even when the app is closed
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      } else {
        flutterLocalNotificationsPlugin.zonedSchedule(
          i,
          'ASSALAM', // Title
          notificationBody, // Body
          tz.TZDateTime.from(scheduledDate2, tz.local), // Scheduled time
          platform,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  }



//====================notification end ==================//
  //====================get location start ==================//

  PermissionStatus _permissionStatus = PermissionStatus.denied;
  String _country = '';

  // Get the current location
  _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        _country = placemarks.first.administrativeArea ?? 'Unknown';
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // Check location permission
  _checkPermission() async {
    PermissionStatus status = await Permission.location.request();
    setState(() {
      _permissionStatus = status;
    });
    if (status == PermissionStatus.granted) {
      _getLocation();
    }
  }
  //====================get location end ==================//

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    String formattedTime = "${now.hour}:${now.minute}";

    return Scaffold(
      appBar: AppBar(
       leading: Padding(
         padding: const EdgeInsets.all(8.0),
         child: CircleAvatar(backgroundImage: NetworkImage("https://mybeautybrides.net/images/30-1594628321285.jpg"),),
       ),
        title: Text("Hannah Delisha",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xF3044204),
      ),
      backgroundColor: CupertinoColors.activeGreen.withOpacity(0.9),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //=================================================//
                Stack(
                  children: [

                    Card(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 60),
                          height: 200,
                          width: MediaQuery.of(context).size.width/1,
                          color: Color(0xF3044204),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 160,
                                    width: MediaQuery.of(context).size.width/2,
                                    color: Color(0xF3044204),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Prayer Time",style: TextStyle(color: Colors.white),),
                                        ),
                                        Text("13:00",style: TextStyle(color: Colors.white),),
                                        Text("Asr",style: TextStyle(color: Colors.white),),
                      // rainbow text
                                      SizedBox(height: 20,),
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GradientAnimationText(
                                              text: Text(
                                                " Get Premium",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              colors: [
                                                Color(0xff8f00ff),  // violet
                                                Colors.indigo,
                                                Colors.blue,
                                                Colors.green,
                                                Colors.yellow,
                                                Colors.orange,
                                                Colors.red,
                                              ],
                                              duration: Duration(seconds: 5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 160,
                                    width: MediaQuery.of(context).size.width/3.5,
                                    child: Image.asset('assets/images/bg_mosque.png'),
                                  ),
                                ],
                              ),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 35,
                                      margin: EdgeInsets.only(left: 10,top: 4),
                                      width: MediaQuery.of(context).size.width/1.5,
                                      child:Text('Current Location: $_country',) ,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                    ),

                    Center(
                      child: CustomClipperWidget(
                        mode: ClipperMode.concave,
                        curvePoint: 7,
                        child: Container(
                          height: 90,
                          // width: 345,
                          width: MediaQuery.of(context).size.width/1.1398,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(bottom: 60,left: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.alarm,color: Colors.white60,),
                                  Text(formattedTime,style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 60,right: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.date_range,color: Colors.white60,),
                                    Text(formattedDate,style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          decoration: const  BoxDecoration(
                            color: Color(0xF3044204)
                          ),
                        ),
                      ),
                    ),

                    //=============================new end============//

                  ],
                ),
                const SizedBox(height: 30),
                // Grid view
                SizedBox(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: screenSize.width / 45,
                    mainAxisSpacing: screenSize.height / 98.5,
                    shrinkWrap: true,
                    childAspectRatio: 1,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridViewContainerCard(
                        image: 'assets/icons/tasbih.png',
                        text: 'Tasbih',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TasbihPage())),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/hadith.png',
                        text: 'Hadith',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HadithPage())),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/pray.png',
                        text: 'Dua',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DuaPage())),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/quran_colorful.png',
                        text: 'Al-Quran',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuranPage())),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/kaaba.png',
                        text: 'Qiblah',
                        onPressed: () => Get.to(QiblaPage(), duration: Duration(milliseconds: 600)),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/more.png',
                        text: 'More',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MorePage())),
                      ),
                    ],
                  ),
                ),

                //======start chatbot===================//
                const SizedBox(height: 20,),

                SwipeableButtonView(
                  buttonText: 'Ask anything Assalam Chatbot',
                  buttonWidget: Container(
                    child: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),),
                  activeColor: Color(0xFF009C41),
                  isFinished: isFinished,
                  onWaitingProcess: () {
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {

                        showDialog(
                          context: context,
                          builder: (context) => new AlertDialog(
                            title: new Text('Attention !!!'),
                            content: Text(
                                'This Feature will Coming Soon...'),
                            actions: <Widget>[
                              ElevatedButton(onPressed: () {
                                setState(() {
                                  isFinished = true;
                                  Navigator.pop(context);
                                });
                              }, child: Text("okay")),
                            ],
                          ),
                        );

                        // isFinished = true;

                      });
                    });
                  },
                  onFinish: () async {

                    setState(() {
                      isFinished = false;
                    });
                  },
                ),
                const SizedBox(height: 20),
                //========end chatbot===========//
              ],
            ),
          ),
        ),
      ),
    );
  }
}
