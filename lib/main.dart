import 'package:flutter/material.dart';
import 'package:sound_notes/core/appData/appColor.dart';
import 'package:sound_notes/core/responsive%20helper/size_config.dart';
import 'package:sound_notes/view/screens/echoNoteScreen.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.transparent),
        scaffoldBackgroundColor: AppColor.mainAppColor,
      ),
      debugShowCheckedModeBanner: false,
      home: EchoNoteScreen(),
    );
  }
}
