import 'package:flutter/material.dart';
import 'package:sound_notes/core/classes/transitions.dart';
import 'package:sound_notes/core/extentions/size-config-extentions.dart';
import 'package:sound_notes/view/screens/newVoiceNoteScreen.dart';

import '../../../core/appData/appColor.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      right: 20.w,
      left: 20.w,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(50),
          ),
        ),
        width: double.infinity,
        height: 200,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Icon(
              Icons.offline_bolt_outlined,
              color: Colors.blue.shade900,
              size: 45,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue.shade800,
              radius: 40.w,
              child: InkWell(
                autofocus: false,
                onTap: () {
                  push(context, NewVoiceNoteScreen());
                },
                child: Icon(
                  Icons.add_outlined,
                  color: Colors.white60,
                  size: 50.scaleFontSize,
                ),
              ),
            ),
            Icon(
              Icons.format_list_bulleted_rounded,
              color: Colors.blue.shade900,
              size: 45,
            ),
          ],
        ),
      ),
    );
  }
}
