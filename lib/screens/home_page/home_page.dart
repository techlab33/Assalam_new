
import 'dart:async';
import 'dart:convert';
import 'package:assalam/data/models/prayer_time_models/prayer_time_data_model.dart';
import 'package:assalam/data/models/profile/user_profile_data_model.dart';
import 'package:assalam/data/services/location_service/location_service.dart';
import 'package:assalam/data/services/prayer_times/prayer_time_get_data.dart';
import 'package:assalam/data/services/profile/get_user_profile_data.dart';
import 'package:assalam/screens/hadith_page/hadith_page.dart';
import 'package:assalam/screens/home_page/username_and_image_page.dart';
import 'package:assalam/screens/home_page/widgets/gird_view_container_card.dart';
import 'package:assalam/screens/live_stream/live_stream.dart';
import 'package:assalam/screens/prayer_page/next_prayer_countdown.dart';
import 'package:assalam/screens/prayer_page/prayer_page.dart';
import 'package:assalam/screens/quran_page/quran_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AudioPlayer audioPlayer;

  bool _isPlaying = false;
  late SharedPreferences _prefs;
  //
  late DateTime dateTime;
  late String formattedDate;

  String ? currentCity;
  String ? currentCountry;
  PrayerTimeDataModel? prayerTimeDataModel;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    initNotifications();
    downloadJson();
    tz.initializeTimeZones();
    // Location
    fetchLocation();
    // Initialize dateTime in the initState method
    dateTime = DateTime.now();
    // Format the current date
    formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  }

  // =============> Audio Player Start <==============
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

  //=============== Audio End =======//

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
          androidAllowWhileIdle: false, // Allow notification even when the app is closed
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


  // =============> Prayer Time Data Start <==============
  final prayerTimeGetData = PrayerTimeGetData();
  // =============> Prayer Time Data End <==============

  // =============> Get User Current Location Start <==============
  Future<void> fetchLocation() async {
    await LocationService().requestPermissionAndFetchLocation();
    setState(() {
      currentCity = LocationService().currentCity;
      currentCountry = LocationService().currentCountry;
    });

    if (currentCity != null && currentCountry != null) {
      prayerTimeDataModel = await prayerTimeGetData.fetchPrayerTimeData(currentCity!, currentCountry!);
      setState(() {});
    }
  }
  // =============> Get User Current Location End <==============

  // --------> User Profile Data <--------
  var fetchProfileData = UserProfileGetData();
  // --------> User Profile Data Get <--------



  @override
  Widget build(BuildContext context) {
    // Hijri date
    HijriCalendar _today = HijriCalendar.now();
    String hijriDate = _today.toFormat("dd MMMM yyyy");
    // Screen Size
    var screenSize = MediaQuery.of(context).size;

    UserProfileDataModel userProfileDataModel;

    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    String formattedTime = "${now.hour}:${now.minute}";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          // -------------> New Design Start <-------------

          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(239, 229, 223, 1),
              image: DecorationImage(
                image: AssetImage('assets/images/flower-pattern-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
             child:  Stack(
                children: [
                  // ------>  Left & Right corner image  <---------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/left_corner.png',),
                      Image.asset('assets/images/right_corner.png',),
                    ],
                  ),

                  // ------>  Design  <---------
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                           height:  screenSize.height / 1.06,
                          width: screenSize.width / 1.16,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/dome-design.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              // ------>  Assalam Logo  <---------
                              Container(
                                margin: EdgeInsets.only(top: 80),
                                child: Image.asset('assets/logos/logo_assalam_hijau.png', height: 75, width: 100),
                              ),

                              // ------>  Assalamualaikum Text User Name Text & User Image  <-------
                              UsernameAndImagePage(),

                              SizedBox(height: 6),

                              // ------> Subscription Banner Image  <-------
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Container(
                                  height: 70,
                                  width: 270,
                                  decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/get-more-features-banner-img.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                ),
                              ),
                              SizedBox(height: 8),

                              // ------> Location & Prayer time & date  <-------
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  height: 92,
                                  width: 270,
                                  color: Color.fromRGBO(5, 145, 5, 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // ------> Date time & Location  <-------
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(formattedDate, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
                                          SizedBox(height: 3),
                                          Text(hijriDate, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
                                          SizedBox(height: 5),

                                          Row(
                                            children: [
                                              Icon(Icons.location_on_outlined, size: 20, color: Colors.white),
                                              SizedBox(width: 5),
                                              Text(
                                                '$currentCity, \n$currentCountry',
                                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12),
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // Divider Container
                                      Container(
                                        height: 70,
                                        width: 1,
                                        color: Colors.white,
                                      ),

                                      // ------> Next Prayer And Time  <-------

                                      currentCity != null && currentCountry != null && prayerTimeDataModel != null
                                          ? Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('Next Prayer', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
                                          SizedBox(height: 4),
                                          NextPrayerCountdown(prayerTimeDataModel: prayerTimeDataModel!),
                                        ],
                                      ) : Center(child: CircularProgressIndicator()),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      //  Home Page Items
                    ],
                  ),

                  // ---------> Home Page Items <----------
                  Container(
                    margin: EdgeInsets.only(top: 410),
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
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
                                image: 'assets/images/prayer-time-icon.png',
                                text: 'Prayer Times',
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrayerPage())),
                              ),
                              GridViewContainerCard(
                                image: 'assets/images/quran-icon.png',
                                text: 'Quran',
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuranPage())),
                              ),
                              GridViewContainerCard(
                                image: 'assets/images/hadith-book-icon.png',
                                text: 'Hadith',
                                onPressed: () {
                                  Get.to(HadithPage(), duration: Duration(milliseconds: 600));
                                },
                              ),
                              GridViewContainerCard(
                                image: 'assets/images/live-mecca-icon.png',
                                text: 'Live Mecca',
                                // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuranPage())),
                              ),
                              GridViewContainerCard(
                                image: 'assets/images/live-medina-icon.png',
                                text: 'Live Medina',
                                // onPressed: () => Get.to(QiblaPage(), duration: Duration(milliseconds: 600)),
                              ),
                              GridViewContainerCard(
                                image: 'assets/images/live-assalam-icon.png',
                                text: 'Live Assalam',
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  LiveStreamPage(title: '',))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
          // -------------> New Design End <-------------
        ),
      ),
    );
  }
}
