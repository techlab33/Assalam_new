import 'package:assalam/utils/constants/colors.dart';
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
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: TColors.primaryColor,
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            // Image
            Image.asset(image, height: 45, width: 45),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
