import 'dart:developer';

import 'package:assalam/controller/prayer_time_controller.dart';
import 'package:assalam/data/models/prayer_time_models/prayer_time_data_model.dart';
import 'package:assalam/data/services/prayer_times/prayer_time_get_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrayerPage extends StatefulWidget {
  PrayerPage({Key? key}) : super(key: key);
  

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  final controller = Get.put(PrayerTimeController());
  final prayerTimeGetData = PrayerTimeGetData();

  late DateTime dateTime;
  late String formattedDate;

  String ? currentCity;
  String ? currentCountry;

  @override
  void initState() {
    super.initState();
    requestPermission();
    // Initialize dateTime in the initState method
    dateTime = DateTime.now();
    // Format the current date
    formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  }


  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

    } else if (permission == LocationPermission.deniedForever) {
      // Handle if permission is permanently denied
    } else {
      // Permission granted, get current location
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      print('City: ${placemark.locality}, Country: ${placemark.country}');
      setState(() {
        currentCity = placemark.locality;
        currentCountry = placemark.country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prayers',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                // User location & current date time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 25),
                        SizedBox(width: 5),
                        Text(
                          '$currentCity, \n$currentCountry',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontSize: 15),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '12 Shawal 1424',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontSize: 15),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),

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
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            PrayerCard(
                              prayerName: 'Imsak',
                              prayerTime: prayerTimeDataModel.data!.timings.imsak,
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),

                            PrayerCard(
                              prayerName: 'Fajr',
                              prayerTime: prayerTimeDataModel.data!.timings.fajr,
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            PrayerCard(
                              prayerName: 'Sunrise',
                              prayerTime: prayerTimeDataModel.data!.timings.sunrise,
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            PrayerCard(
                              prayerName: 'Dhuhr',
                              prayerTime: prayerTimeDataModel.data!.timings.dhuhr,
                            ),

                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            PrayerCard(
                              prayerName: 'Asr',
                              prayerTime: prayerTimeDataModel.data!.timings.asr,
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            PrayerCard(
                              prayerName: 'Maghrib',
                              prayerTime: prayerTimeDataModel.data!.timings.maghrib,
                            ),

                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),

                            PrayerCard(
                              prayerName: 'Sunset',
                              prayerTime: prayerTimeDataModel.data!.timings.sunset,
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            PrayerCard(
                              prayerName: 'Isha',
                              prayerTime: prayerTimeDataModel.data!.timings.isha,
                            ),

                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),

                            PrayerCard(
                              prayerName: 'First third',
                              prayerTime: prayerTimeDataModel.data!.timings.firstthird,
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            PrayerCard(
                              prayerName: 'Midnight',
                              prayerTime: prayerTimeDataModel.data!.timings.midnight,
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            PrayerCard(
                              prayerName: 'Last third',
                              prayerTime: prayerTimeDataModel.data!.timings.lastthird,
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
  });

  String prayerTime;
  String prayerName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.sunny),
            SizedBox(width: 8),
            Text(prayerName, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15)),
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
