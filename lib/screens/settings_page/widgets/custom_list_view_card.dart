import 'package:flutter/material.dart';

class CustomListViewCard extends StatelessWidget {
  CustomListViewCard({
    super.key,
    required this.text,
    required this.image,
    required this.icon,
    required this.onPressed,
  });

  String text;
  String image;
  IconData icon;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        title: Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        leading: Image.asset(image, height: 25, width: 25),
        trailing:  Icon(icon, size: 18),
      ),
    );
  }
}