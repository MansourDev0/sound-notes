import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_notes/controller/newVoiceNoteController.dart';
import 'package:sound_notes/core/extentions/size-config-extentions.dart';
import 'package:sound_notes/core/functions/spaces.dart';
import 'package:sound_notes/core/models/recordModel.dart';
import 'package:sound_notes/repositories/newVoiceNoteRepo.dart';
import 'package:sound_notes/view/widgets/customWidgets/customTextWidget.dart';
import 'package:sound_notes/view/widgets/newVoiceNoteWidgets/recordingWavWidget.dart';

import '../../core/constants.dart';

class NewVoiceNoteScreen extends StatelessWidget {
  const NewVoiceNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NewVoiceNoteController());
    return Scaffold(
      appBar: newVoiceNoteAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          spaceW(double.infinity),
          spaceH(80),
          RecordingWavWidget(),

          GetBuilder<NewVoiceNoteController>(
            builder: (x) {
              return Column(
                children: [
                  if (AppConstants.allRecords.isEmpty)
                    CustomText(text: 'لا يوجد تسجيلات بعد'),
                  Container(
                    color: Colors.redAccent,
                    height: 300,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CustomText(
                          text: AppConstants.allRecords[index].recordPath,
                        );
                      },
                      itemExtent: 100,
                      itemCount: AppConstants.allRecords.length,
                    ),
                  ),
                  spaceH(50),
                  CustomText(text: '${(x.seconds)}'),
                  InkWell(
                    onTap: () async {
                      String path = await NewVoiceNoteRepoImp().getPath();
                      myPrint(path);
                      x.isRecording
                          ? x.stopMethods()
                          : x.startMethods(
                            RecordModel(
                              recordPath: path,
                              title: 'العنوان',
                              description: 'الوصف',
                              time: DateTime.now(),
                            ),
                          );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 55.w,
                          backgroundColor: Colors.white38.withOpacity(0.05),
                        ),
                        CircleAvatar(
                          radius: 40.w,
                          backgroundColor: Colors.blue.shade900,
                          child: FittedBox(
                            child: Icon(
                              x.isRecording
                                  ? Icons.pause
                                  : Icons.keyboard_voice,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  spaceH(50),
                ],
              );
            },
          ),

          spaceH(50),
        ],
      ),
    );
  }
}

AppBar newVoiceNoteAppBar(context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        // pop(context, EchoNoteScreen());
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white60),
    ),
    title: CustomText(
      text: 'New Voice Note',
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  );
}

// سؤال للشات
//كيف اعمل دالة print تطبع كل النص ما يقصة, لانه دالة الprint العادية لها حد معين من احرف الطباعة
