import 'package:flutter/material.dart';

class SizeConfig {
  // خصائص لحجم الشاشة
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  // خصائص لملاءمة النصوص والصور
  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;
  static late double widthMultiplier;

  // خصائص تتعلق بنسب الشاشة
  static late double deviceRatio;
  static late bool isPortrait;
  static late bool isMobilePortrait;

  // متغيرات للـ MediaQuery و SafeArea
  static MediaQueryData? _mediaQueryData;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  // دالة تهيئة حجم الشاشة بناءً على الـ BuildContext
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    // تهيئة الأبعاد الرئيسية
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;

    // حساب المساحات الآمنة من الحواف
    _safeAreaHorizontal = _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical = _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;

    // حساب المساحات الآمنة داخل الشاشة
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical!) / 100;

    // تهيئة المعاملات اللازمة للتناسب
    textMultiplier = blockWidth;
    imageSizeMultiplier = blockWidth;
    heightMultiplier = blockHeight;
    widthMultiplier = blockWidth;

    // حساب نسبة العرض إلى الارتفاع
    deviceRatio = screenWidth / screenHeight;

    // تحديد اتجاه الشاشة
    isPortrait = screenHeight > screenWidth;
    isMobilePortrait = isPortrait && screenWidth < 450;
  }

  // دالة لضبط حجم النص بناءً على حجم الشاشة
  static double scaleTextFont(double fontSize) {
    double scale = fontSize / 3.75;
    return (textMultiplier * scale);
  }

  // دالة لضبط عرض العنصر بناءً على حجم الشاشة
  static double scaleWidth(double width) {
    double scale = width / 3.75;
    return (widthMultiplier * scale);
  }

  // دالة لضبط ارتفاع العنصر بناءً على حجم الشاشة
  static double scaleHeight(double height) {
    double scale = height / 8.12;
    return (heightMultiplier * scale);
  }
}
