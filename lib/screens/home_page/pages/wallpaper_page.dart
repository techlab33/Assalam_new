import 'package:flutter/material.dart';

class WallpaperPage extends StatelessWidget {
  const WallpaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper', style: TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }
}
