import 'dart:async'; // تأكد من إضافة هذه المكتبة

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:sound_notes/core/constants.dart';
import 'package:sound_notes/core/functions/printing.dart';
import 'package:sound_notes/core/models/recordModel.dart';
import 'package:sound_notes/repositories/newVoiceNoteRepo.dart';
import 'package:record/record.dart';

class NewVoiceNoteController extends GetxController {
  // ----------------------------------------------------------------------------------
  bool isRecording = false;
  FlutterSoundRecorder? soundRecorder;
  late Timer timer;
  int seconds = 0;
  final int maxRecordingTime = 10 * 60;
  final NewVoiceNoteRepoImp _newVoiceNoteRepo = NewVoiceNoteRepoImp();

  // ----------------------------------------------------------------------------------

  void startMethods(dataModel) async {
    await startRecord2(dataModel);
    // _startTimer();
    // isRecording = true;
    // seconds = 0;
    // AppConstants.allRecords = await _newVoiceNoteRepo.getAllRecordings();
    // myPrint(AppConstants.allRecords);
    update();
  }

  void stopMethods() async {
    await stopRecord();
    _stopTimer();
    isRecording = false;
    _newVoiceNoteRepo.getAllRecordings();
    update();
  }

  // ----------------------------------------------------------------------------------

  // --- start
  // await _newVoiceNoteRepo.saveRecordData(dataModel);

  Future<void> startRecord(RecordModel dataModel) async {
    await _newVoiceNoteRepo.checkPermission();
    await _newVoiceNoteRepo.openRecorder();

    try {
      // بدء التسجيل
      await soundRecorder?.startRecorder(
        toFile: dataModel.recordPath,
        codec: Codec.aacADTS,
      );

      // تأكد من أن التسجيل بدأ
      bool isRecording = soundRecorder?.isRecording ?? false;
      myPrint(
        'Is Recording: $isRecording',
      ); // طباعة حالة التسجيل (يجب أن تكون true)

      if (!isRecording) {
        myPrint('Failed to start recording!');
        return; // إيقاف تنفيذ الكود إذا لم يبدأ التسجيل
      }

      // انتظر قليلاً
      myPrint('start timer');
      await Future.delayed(Duration(seconds: 3));
      myPrint('finished timer');

      // إيقاف التسجيل
      String? result = await soundRecorder?.stopRecorder();
      myPrint('Recording stopped. Path: $result'); // طباعة المسار الناتج
    } catch (e) {
      myPrint('Err:$e');
    }
  }

  Future<void> startRecord2(RecordModel dataModel) async {
    await _newVoiceNoteRepo.checkPermission();

    // Initialize the Record instance
    final record = AudioRecorder();

    try {
      // Check if recording is supported
      bool hasPermission = await record.hasPermission();
      if (!hasPermission) {
        myPrint('Recording permission denied!');
        return;
      }

      // Start recording
      await record.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: dataModel.recordPath,
      );
      // Verify recording started
      bool isRecording = await record.isRecording();
      myPrint('Is Recording: $isRecording'); // Should print true

      if (!isRecording) {
        myPrint('Failed to start recording!');
        return;
      }
      // Wait for 3 seconds
      myPrint('start timer');
      await Future.delayed(Duration(seconds: 5));
      myPrint('finished timer');

      // Stop recording
      String? result = await record.stop();
      myPrint('Recording stopped. Path: $result'); // Print the output path
    } catch (e) {
      myPrint('Err:$e');
    } finally {
      // تنظيف الموارد
      await record.dispose();
    }
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds < maxRecordingTime) {
        seconds++;
        update(); // تحديث الواجهة كل ثانية
      } else {
        stopMethods();
      }
    });
  }

  // --- stop

  Future<void> stopRecord() async {
    await soundRecorder?.stopRecorder();
    await soundRecorder?.closeRecorder();
  }

  void _stopTimer() {
    timer.cancel();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await _newVoiceNoteRepo.openRecorder();
    AppConstants.allRecords = await _newVoiceNoteRepo.getAllRecordings();
    update();
    super.onInit();
  }
}
