import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_notes/controller/viewRecordNoteListController.dart';
import 'package:sound_notes/core/extentions/size-config-extentions.dart';

import '../../../core/appData/appColor.dart';
import '../../../core/constants.dart';
import '../../../core/functions/spaces.dart';
import '../customWidgets/customTextWidget.dart';

class ViewRecordNoteListWidget extends StatelessWidget {
  const ViewRecordNoteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        // color: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: Column(children: [CardEchoNote()]),
      ),
    );
  }
}

class CardEchoNote extends StatelessWidget {
  const CardEchoNote({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewRecordNoteListController());

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Card(
        color: AppColor.cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Row(
            children: [
              spaceW(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Meeting Notes',
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  CustomText(
                    text: 'Apr 21, 10:30 AM',
                    fontSize: 14,
                    color: Colors.white60,
                  ),
                ],
              ),
              Spacer(),
              GetBuilder<ViewRecordNoteListController>(
                builder: (x) {
                  return InkWell(
                    onTap: () async {
                      myPrint(AppConstants.allRecords);
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF2563EB),
                      child: Icon(Icons.play_arrow, color: Colors.white60),
                    ),
                  );
                },
              ),

              spaceW(15),
            ],
          ),
        ),
      ),
    );
  }
}
