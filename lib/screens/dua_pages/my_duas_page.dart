import 'package:assalam/screens/dua_pages/dua_chack_page.dart';
import 'package:assalam/screens/dua_pages/dua_favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyDuasPage extends StatelessWidget {
  const MyDuasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [

              ListTile(
                title: Text('Favorite', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                leading: Icon(Icons.favorite, color: Colors.red),
                trailing: Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () => Get.to(DuaFavoritePage()),
              ),
              Divider(),
              ListTile(
                title: Text('Checkout', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                leading: Icon(Icons.check_box_outlined, color: Colors.green,),
                trailing: Icon(Icons.arrow_forward_ios, size: 20,),
                onTap: () => Get.to(DuaCheckPage()),
              ),Divider(),
              ListTile(
                title: Text('Notes', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                leading: Icon(Icons.edit, color: Colors.green,),
                trailing: Icon(Icons.arrow_forward_ios, size: 20,),
                onTap: () {
                  //Navigator.of(context).pushNamed('/myduas');
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
