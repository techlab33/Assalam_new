
import 'dart:async';
import 'dart:convert';
import 'dart:math';

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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:swipeable_button_view/swipeable_button_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AudioPlayer audioPlayer;

  bool _isPlaying = false;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    initNotifications();
    downloadJson();
    _getLocation();
    _checkPermission();
  }

  Future<void> initializePlayer() async {
    _prefs = await SharedPreferences.getInstance();
    bool? audioPlayed = _prefs.getBool('audioPlayed');
    if (audioPlayed == null || !audioPlayed) {
      audioPlayer = AudioPlayer();
      await playAudio();
      _prefs.setBool('audioPlayed', true);
    }
  }

  Future<void> playAudio() async {
    if (!_isPlaying) {
      await audioPlayer.play(AssetSource('bismillah.mp3'));
      setState(() {
        _isPlaying = true;
      });
    }
  }

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

  // @override
  // void initState() {
  //   super.initState();
  //   initNotifications();
  //   downloadJson();
  // }

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
        startNotificationTimer();
      });
    } else {
      throw Exception("Something went wrong while fetching data.");
    }
  }

  void startNotificationTimer() {
    Timer.periodic(Duration(seconds: 20), (timer) {
      if (posts.isNotEmpty) {
        showNotification();
        setState(() {
          currentIndex = (currentIndex + 1) % posts.length;
        });
      }
    });
  }

  Future<void> showNotification() async {
    if (posts.isNotEmpty) {
      final notificationBody = posts[currentIndex]['name'] as String;
      final android = AndroidNotificationDetails(
        'scheduled_notification',
        'Scheduled Notifications',
        importance: Importance.high,
      );
      // final iOS = IOSNotificationDetails();
      final platform = NotificationDetails(android: android);

      await flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        'ASSALAM',
        notificationBody,
        platform,
        payload: 'New Notification',
      );
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
                    // Container(
                    //   height: 180,
                    //   width: screenSize.width,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     image: DecorationImage(
                    //       image: AssetImage('assets/images/islam-background.jpg'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 50),
                    //     height: 160,
                    //     width: screenSize.width / 1.3,
                    //     decoration: BoxDecoration(
                    //         // color: Colors.grey.shade200,
                    //         borderRadius: BorderRadius.circular(15)
                    //     ),
                    //     child: Card(
                    //       elevation: 4,
                    //       color: Color(0xF3044204),
                    //       child: Padding(
                    //         padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //
                    //             // user profile & Get premium
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     CircleAvatar(
                    //                       child: Image.asset('assets/icons/user.png', height: 25, width: 25),
                    //                       radius: 18,
                    //                     ),
                    //                     const SizedBox(width: 5),
                    //                     Text('Ifran '
                    //                         '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
                    //                   ],
                    //                 ),
                    //                 Container(
                    //                   height: 30,
                    //                   width: 110,
                    //                   alignment: Alignment.center,
                    //                   padding: EdgeInsets.symmetric(horizontal: 5),
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(100),
                    //                     color: Colors.deepPurple.shade500,
                    //                   ),
                    //                   child: Text('Get Premium', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.yellow)),
                    //                 )
                    //               ],
                    //             ),
                    //
                    //             // Prayer time & location
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               crossAxisAlignment: CrossAxisAlignment.end,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text('Asr',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                    //                     Text('12:45 PM',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                    //                     Text('View Time',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                    //                   ],
                    //                 ),
                    //
                    //                 //
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.end,
                    //                   children: [
                    //                     Text('23 Shawal, 1445 AH',style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
                    //                     Text('Dhaka, Bangladesh',style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
                    //                     // Text('View Time',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20,),

                SwipeableButtonView(
                  buttonText: 'Ask anything with Chatbot',
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

                const SizedBox(height: 40),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
