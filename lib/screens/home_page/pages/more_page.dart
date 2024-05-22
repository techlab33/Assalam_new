import 'package:assalam/screens/dua_pages/dua_page.dart';
import 'package:assalam/screens/hadith_page/hadith_page.dart';
import 'package:assalam/screens/home_page/pages/tasbih_page.dart';
import 'package:assalam/screens/home_page/widgets/gird_view_container_card.dart';
import 'package:assalam/screens/jakat_page/jakat_page.dart';
import 'package:assalam/screens/live_stream/live_stream.dart';
import 'package:assalam/screens/qiblah_page/qiblah_page.dart';
import 'package:assalam/screens/quran_page/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width/1,
                  child: Image.asset("assets/logos/assalam_green-logo.png",fit: BoxFit.cover,),
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
                    physics:const NeverScrollableScrollPhysics(),
                    children: [
                      GridViewContainerCard(
                        image: 'assets/icons/tasbih.png',
                        text: 'Tasbih',
                        onPressed: () => Get.to(TasbihPage(), duration: Duration(milliseconds: 600)),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/hadith.png',
                        text: 'Hadith',
                        onPressed: () => Get.to(HadithPage(), duration: Duration(milliseconds: 600)),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/pray.png',
                        text: 'Dua',
                        onPressed: () => Get.to(DuaPage(), duration: Duration(milliseconds: 600)),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/quran_colorful.png',
                        text: 'Al-Quran',
                        onPressed: () => Get.to(QuranPage(), duration: Duration(milliseconds: 600)),
                      ),

                      GridViewContainerCard(
                        image: 'assets/icons/calculator.png',
                        text: 'Jakat',
                        onPressed: () => Get.to(ZakatCalculatorPage(), duration: Duration(milliseconds: 600)),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/kaaba.png',
                        text: 'Qiblah',
                        onPressed: () => Get.to(QiblaPage(), duration: Duration(milliseconds: 600)),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/live_stream.png',
                        text: 'Live Stream',
                        onPressed: () => Get.to(LiveStreamPage(title: '',), duration: Duration(milliseconds: 600)),
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
