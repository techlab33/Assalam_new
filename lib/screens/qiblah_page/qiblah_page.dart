import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;


class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  double _direction = 0.0;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((CompassEvent event) {
      setState(() {
        _direction = event.heading!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Qibla Compass",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF035408),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width/1,
            child: Image.asset('assets/logos/assalam_green-logo.png',fit: BoxFit.cover,),
          ),
          SizedBox(height: 20,),
          Stack(
            children: <Widget>[
              // Positioned(bottom: 0, child: Image.asset('assets/images/mosque.png',fit: BoxFit.cover)),
            Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text("Degree : ${_direction == null ? 0 : _direction
                            .toInt()}°", style: TextStyle(fontSize: 18),),
                      ),
                      SizedBox(height: 90,),
                      Center(
                        child: Transform.rotate(angle: ((_direction ?? 0) * (math.pi / 180) * -1),
                          child: Image.asset('assets/images/compass.png'),),
                      ),
                    ],
                  ),
                ),


            ],
          ),
        ],
      ),
    );
  }
}

//      // 'https://dsqqu7oxq6o1v.cloudfront.net/preview-9650dW8x3YLoZ8.webm',
//               "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//               // "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8",
//               // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
//               // "http://54.177.121.234:8080/hls/test.m3u8",
//