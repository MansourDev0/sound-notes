import 'package:flutter/material.dart';
import 'package:sound_notes/core/extentions/size-config-extentions.dart';

class CustomText extends StatelessWidget {
  final String text; // النص الذي سيتم عرضه
  final double fontSize; // حجم النص
  final Color color; // لون النص
  final FontWeight fontWeight; // وزن النص (اختياري)
  final TextAlign textAlign; // وزن النص (اختياري)

  const CustomText({
    super.key,
    required this.text, // النص إلزامي
    this.fontSize = 20, // الحجم الافتراضي 20
    this.color = Colors.white, // اللون الافتراضي أسود
    this.fontWeight = FontWeight.normal, // الوزن الافتراضي هو normal
    this.textAlign = TextAlign.start, // الوزن الافتراضي هو normal
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.scaleFontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
