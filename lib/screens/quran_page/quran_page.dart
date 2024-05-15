// import 'package:assalam/data/models/quran_model/quran_data_model.dart';
// import 'package:assalam/data/services/quran/quran_all_data.dart';
// import 'package:flutter/material.dart';
//
// class QuranPage extends StatefulWidget {
//   const QuranPage({super.key});
//
//   @override
//   State<QuranPage> createState() => _QuranPageState();
// }
//
// class _QuranPageState extends State<QuranPage> {
//
//   //
//   final fetchAllQuran = GetAllQuran();
//
//   @override
//   void initState() {
//     fetchAllQuran.fetchAllQuranData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //
//     QuranDataModel quranDataModel;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Al-Quran', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),),
//         backgroundColor: Colors.green,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//
//               FutureBuilder<QuranDataModel>(
//                 future: fetchAllQuran.fetchAllQuranData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: const CircularProgressIndicator()); // Show a loading indicator while fetching data
//                   } else if (snapshot.hasError) {
//                     print(snapshot.error);
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     quranDataModel = snapshot.data!;
//
//                     return Column(
//
//                       children: [
//                         SizedBox(height: 10),
//                         for (final quran in quranDataModel.data!.surahs)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Card(
//                               child: ListTile(
//
//                                 leading: CircleAvatar(
//                                   radius: 13,
//                                   backgroundColor: Colors.green.shade300,
//                                   child: Text(quran.number.toString(), style: TextStyle(color: Colors.white),),
//                                 ),
//                                 title: Text(quran.englishName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
//                               ),
//                             ),
//                           ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'package:assalam/screens/quran_page/show_quran_page.dart';
import 'package:flutter/material.dart';
import 'package:assalam/data/models/quran_model/quran_data_model.dart';
import 'package:assalam/data/services/quran/quran_all_data.dart';
import 'package:get/get.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final fetchAllQuran = GetAllQuran();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Al-Quran',
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: FutureBuilder<QuranDataModel>(
          future: fetchAllQuran.fetchAllQuranData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              log('Error: ${snapshot.error}');
              return Center(
                child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)),
              ); // Error handling with a user-friendly message
            } else if (snapshot.hasData) {
              final quranDataModel = snapshot.data; // This could be null, so be cautious
              final surahs = quranDataModel?.data?.surahs ?? []; // Default to empty list

              if (surahs.isEmpty) {
                return Center(
                  child: Text('No surahs found'), // Handling the case when there's no data
                );
              }

              return ListView.builder(
                itemCount: surahs.length,
                itemBuilder: (context, index) {
                  final quran = surahs[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    child: Card(
                      child: ListTile(
                        onTap: () => Get.to(ShowQuranPage(
                                  suraID: quran.number.toString(),
                                  suraName: quran.englishName,
                                  quranDataModel: quranDataModel!,
                                )),
                        leading: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.green.shade300,
                          child: Text(
                            quran.number.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        trailing: Text(quran.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        title: Text(quran.englishName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: Text('Ayahs : ${quran.ayahs.length.toString()}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No data available")); // Default message for no data
            }
          },
        ),
      ),
    );
  }
}

