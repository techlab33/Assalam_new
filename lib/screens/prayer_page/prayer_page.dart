import 'package:assalam/data/services/location_service/location_service.dart';
import 'package:assalam/utils/constants/colors.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:assalam/data/models/prayer_time_models/prayer_time_data_model.dart';
import 'package:assalam/data/services/prayer_times/prayer_time_get_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PrayerPage extends StatefulWidget {
  PrayerPage({Key? key}) : super(key: key);
  

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {

  final prayerTimeGetData = PrayerTimeGetData();

  late DateTime dateTime;
  late String formattedDate;

  String ? currentCity;
  String ? currentCountry;

  @override
  void initState() {
    super.initState();
    fetchLocation();
    // Initialize dateTime in the initState method
    dateTime = DateTime.now();
    // Format the current date
    formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  }

  Future<void> fetchLocation() async {
    await LocationService().requestPermissionAndFetchLocation();
    setState(() {
      currentCity = LocationService().currentCity;
      currentCountry = LocationService().currentCountry;
    });

  }


  @override
  Widget build(BuildContext context) {

    // Hijri date
    HijriCalendar _today = HijriCalendar.now();
    String hijriDate = _today.toFormat("dd MMMM yyyy");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prayers',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: TColors.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                // User location & current date time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 25, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          '$currentCity, \n$currentCountry',
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(hijriDate, style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87, fontSize: 15),),
                        Text(formattedDate, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),

                currentCity != null && currentCountry != null ? FutureBuilder<PrayerTimeDataModel>(
                  future: prayerTimeGetData.fetchPrayerTimeData(currentCity!, currentCountry!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null) {
                      return Text('No data available');
                    } else {
                      PrayerTimeDataModel prayerTimeDataModel = snapshot.data!;
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.symmetric(horizontal: BorderSide(color: Colors.green, width: 1),vertical: BorderSide(color: Colors.green, width: 1)),
                        ),
                        child: Column(
                          children: [
                            PrayerCard(
                              image: 'assets/icons/sunrise.png',
                              prayerName: 'Imsak',
                              prayerTime: prayerTimeDataModel.data!.timings.imsak,
                            ),
                            SizedBox(height: 10),
                            Divider(color: Colors.green),
                            SizedBox(height: 10),

                            PrayerCard(
                              image: 'assets/icons/sunrise.png',
                              prayerName: 'Fajr',
                              prayerTime: prayerTimeDataModel.data!.timings.fajr,
                            ),
                            SizedBox(height: 10),
                            Divider(color: Colors.green),
                            SizedBox(height: 10),
                            PrayerCard(
                              image: 'assets/icons/sunrise2.png',
                              prayerName: 'Sunrise',
                              prayerTime: prayerTimeDataModel.data!.timings.sunrise,
                            ),
                            SizedBox(height: 10),
                            Divider(color: Colors.green),
                            SizedBox(height: 10),
                            PrayerCard(
                              image: 'assets/icons/sunrise2.png',
                              prayerName: 'Dhuhr',
                              prayerTime: prayerTimeDataModel.data!.timings.dhuhr,
                            ),

                            SizedBox(height: 10),
                            Divider(color: Colors.green),
                            SizedBox(height: 10),
                            PrayerCard(
                              image: 'assets/icons/sunset.png',
                              prayerName: 'Asr',
                              prayerTime: prayerTimeDataModel.data!.timings.asr,
                            ),
                            SizedBox(height: 10),
                            Divider(color: Colors.green),
                            SizedBox(height: 10),
                            PrayerCard(
                              image: 'assets/icons/sunset.png',
                              prayerName: 'Maghrib',
                              prayerTime: prayerTimeDataModel.data!.timings.maghrib,
                            ),
                            SizedBox(height: 10),
                            Divider(color: Colors.green),
                            SizedBox(height: 10),
                            PrayerCard(
                              image: 'assets/icons/half-moon.png',
                              prayerName: 'Isha',
                              prayerTime: prayerTimeDataModel.data!.timings.isha,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ) : Text('Please Permission Location!!'),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrayerCard extends StatelessWidget {
  PrayerCard({
    super.key,
    required this.prayerTime,
    required this.prayerName,
    required this.image,
  });

  String prayerTime;
  String prayerName;
  String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Icon(Icons.sunny),
            Image.asset(image, height: 25, width: 25),
            SizedBox(width: 8),
            Text(prayerName, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green, fontSize: 15)),
          ],
        ),
        Row(
          children: [
            Text(prayerTime, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15)),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}

