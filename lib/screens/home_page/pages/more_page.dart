import 'package:assalam/screens/dua_pages/dua_page.dart';
import 'package:assalam/screens/hadith_page/hadith_page.dart';
import 'package:assalam/screens/home_page/pages/qiblah_page.dart';
import 'package:assalam/screens/home_page/pages/tasbih_page.dart';
import 'package:assalam/screens/home_page/widgets/gird_view_container_card.dart';
import 'package:assalam/screens/jakat_page/jakat_page.dart';
import 'package:assalam/screens/live_stream/live_stream.dart';
import 'package:assalam/screens/qiblah_page/qiblah_page.dart';
import 'package:assalam/screens/quran_page/quran_page.dart';
import 'package:assalam/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Assalam All Items', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 20)),
        backgroundColor: TColors.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                const SizedBox(height: 10),
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
                        onPressed: () => Get.to(TasbihPage()),
                      ),
                      GridViewContainerCard(
                        image: 'assets/images/quran-icon.png',
                        text: 'Al-Quran',
                        onPressed: () => Get.to(QuranPage()),
                      ),
                      GridViewContainerCard(
                        image: 'assets/images/hadith-book-icon.png',
                        text: 'Hadith',
                        onPressed: () => Get.to(HadithPage()),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/pray.png',
                        text: 'Dua',
                        onPressed: () => Get.to(DuaPage()),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/calculator.png',
                        text: 'Zakat',
                        onPressed: () => Get.to(ZakatCalculatorPage(), duration: Duration(milliseconds: 600)),
                      ),
                      GridViewContainerCard(
                        image: 'assets/icons/kaaba.png',
                        text: 'Qiblah',
                        onPressed: () => Get.to(QiblaPage(), duration: Duration(milliseconds: 600)),
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
