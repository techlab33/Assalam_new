
import 'dart:async';
import 'package:assalam/data/models/prayer_time_models/prayer_time_data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NextPrayerCountdown extends StatefulWidget {
  final PrayerTimeDataModel prayerTimeDataModel;

  const NextPrayerCountdown({required this.prayerTimeDataModel});

  @override
  _NextPrayerCountdownState createState() => _NextPrayerCountdownState();
}

class _NextPrayerCountdownState extends State<NextPrayerCountdown> {
  Timer? _timer;
  String nextPrayerName = '';
  String nextPrayerTime = '';
  String timeUntilNextPrayer = '';

  @override
  void initState() {
    super.initState();
    updateNextPrayerTime();
    startPrayerTimeUpdates();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // =============> Prayer Time Data Start <==============

  void startPrayerTimeUpdates() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      updateNextPrayerTime();
    });
  }

  void updateNextPrayerTime() {
    final now = DateTime.now();
    final prayerTimings = widget.prayerTimeDataModel.data!.timings;
    final nextPrayer = getNextPrayer(now, prayerTimings);

    setState(() {
      nextPrayerName = nextPrayer['name']!;
      nextPrayerTime = nextPrayer['time']!;
      timeUntilNextPrayer = nextPrayer['duration']!;
    });
  }

  Map<String, String> getNextPrayer(DateTime now, Timings prayerTimings) {
    final Map<String, String> prayers = {
      'Fajr': prayerTimings.fajr,
      'Dhuhr': prayerTimings.dhuhr,
      'Asr': prayerTimings.asr,
      'Maghrib': prayerTimings.maghrib,
      'Isha': prayerTimings.isha,
    };

    for (var entry in prayers.entries) {
      final prayerTime = parseTime(entry.value);
      if (now.isBefore(prayerTime)) {
        final duration = prayerTime.difference(now);
        final hours = duration.inHours;
        final minutes = duration.inMinutes % 60;
        return {
          'name': entry.key,
          'time': DateFormat.jm().format(prayerTime), // Format time
          'duration': '$hours hours $minutes minutes',
        };
      }
    }

    // If no upcoming prayer, return the next day's Fajr
    final fajrTime = parseTime(prayers['Fajr']!).add(Duration(days: 1));
    final duration = fajrTime.difference(now);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return {
      'name': 'Fajr',
      'time': DateFormat.jm().format(fajrTime), // Format time
      'duration': '$hours hours $minutes minutes',
    };
  }

  DateTime parseTime(String time) {
    final now = DateTime.now();
    final parts = time.split(':');
    return DateTime(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
  }

  // =============> Prayer Time Data End <==============

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Image.asset('assets/icons/zuhr-sun-icon.png', height: 20, width: 20, color: Colors.white),
            SizedBox(width: 5),
            Text('$nextPrayerName, $nextPrayerTime', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white)),
          ],
        ),
        SizedBox(height: 4),
        Text('$nextPrayerName prayer next in\n$timeUntilNextPrayer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
      ],
    );
  }
}