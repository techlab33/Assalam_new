import 'package:flutter/material.dart';


class GridViewContainerCard extends StatelessWidget {
  GridViewContainerCard({
    super.key,
    required this.image,
    required this.text,
    this.onPressed,
  });

  String image;
  String text;
  void Function() ? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xF3044204),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            // Image
            Image.asset(image, height: 36, width: 36),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
