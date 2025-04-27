import 'package:flutter/material.dart';
import 'package:sound_notes/view/widgets/customWidgets/customTextWidget.dart';
import 'package:sound_notes/view/widgets/echoNoteWidgets/bottomNavWidget.dart';
import 'package:sound_notes/view/widgets/echoNoteWidgets/viewRecordNoteListWidget.dart';

class EchoNoteScreen extends StatelessWidget {
  const EchoNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'EchoNote',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Stack(children: [ViewRecordNoteListWidget(), BottomNavWidget()]),
    );
  }
}
