
import 'package:assalam/data/models/dua_model/dua_data_model.dart';
import 'package:assalam/data/services/dua/get_all_dua.dart';
import 'package:assalam/screens/dua_pages/morning_evening.dart';
import 'package:assalam/screens/dua_pages/widgets/dua_card_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../settings_page/language_controller.dart';


class DuaCategoryPage extends StatefulWidget {
  const DuaCategoryPage({super.key});

  @override
  State<DuaCategoryPage> createState() => _DuaCategoryPageState();
}

class _DuaCategoryPageState extends State<DuaCategoryPage> {

  final fetchAllDua = GetAllDua();

  @override
  void initState() {
    // _updateTargetLanguage();
   fetchAllDua.fetchAllDuaData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    DuaDataModel duaDataModel;

    // Screen Size
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [

              FutureBuilder<DuaDataModel>(
                future: fetchAllDua.fetchAllDuaData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show a loading indicator while fetching data
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    duaDataModel = snapshot.data!;

                    return SizedBox(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: screenSize.width / 45,
                        mainAxisSpacing: screenSize.height / 98.5,
                        shrinkWrap: true,
                        childAspectRatio: 1.4,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [

                          for (final categoryName in duaDataModel.allCategories!)
                          DuaContainerCard(
                            title: categoryName.categoryName,
                            subtitle: categoryName.totalSubCategories.toString(),
                            color: Colors.blue.shade200,
                            onPressed: () => Get.to(MorningAndEveningPage(categoryName: categoryName.categoryName,duaDataModel: duaDataModel, categoryID: categoryName.id.toString(),)),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}