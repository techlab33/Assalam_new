import 'package:assalam/screens/dua_pages/category_page.dart';
import 'package:assalam/screens/dua_pages/my_duas_page.dart';
import 'package:flutter/material.dart';

class DuaPage extends StatelessWidget {
  const DuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dua', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
          backgroundColor: Colors.green,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Category',style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              Tab(
                child: Text('My Duas', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DuaCategoryPage(),
            MyDuasPage(),
          ],
        ),
      ),
    );
  }
}
