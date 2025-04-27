import 'dart:async'; // تأكد من إضافة هذه المكتبة
import 'dart:convert';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_notes/core/constants.dart';
import 'package:sound_notes/core/functions/printing.dart';
import 'package:sound_notes/core/models/recordModel.dart';

// هذا الكلاس مختص بالدوال الرئيسية التي تعمل في الصفحات
// ويتم اخذ instance منه واستدعاء الدوال المطلوبة
abstract class NewVoiceNoteRepo {
  // فحص امكانية الوصول الى التسجيل الصوتي والملفات
  Future<void> checkPermission();

  // فتح التسجيل(مهم من المكتبة نفسها)
  Future<void> openRecorder();

  // انشاء المسار
  Future<String> getPath();

  // حفظ التسجيل مع تفاصيله في ملف باستخدام json
  Future<void> saveRecordData(RecordModel model);

  //list RecordModel جلب كل التسجيلات يرجع
  Future<List<RecordModel>> getAllRecordings();
}

class NewVoiceNoteRepoImp extends NewVoiceNoteRepo {
  FlutterSoundRecorder? soundRecorder;

  @override
  Future<void> checkPermission() async {
    var micStatus = await Permission.microphone.status;
    if (!micStatus.isGranted) {
      await Permission.microphone.request();
    }

    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Future<void> openRecorder() async {
    // soundRecorder ??= FlutterSoundRecorder();
    await soundRecorder?.openRecorder(); // فتح المسجل.
  }

  @override
  Future<String> getPath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    if (!await appDocDir.exists()) {
      await appDocDir.create(recursive: true);
    }
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String newPath = '${appDocDir.path}/recording_$timeStamp.aac';
    return newPath;
  }

  @override
  Future<void> saveRecordData(RecordModel record) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    // مسار الملف الرئيسي
    final String filePath = '${appDocDir.path}/records.json';
    // الملف الرئيسي
    final File file = File(filePath);
    if (await file.exists()) {
      final String content = await file.readAsString();
      final List<dynamic> data = jsonDecode(content);
      myPrint('myData = $data');
      AppConstants.allRecords =
          data.map((e) {
            return RecordModel.fromJson(e);
          }).toList();
    }
    AppConstants.allRecords.add(record);
    final String updatedContent = jsonEncode(
      AppConstants.allRecords.map((e) => e.toJson()).toList(),
    );
    await file.writeAsString(updatedContent);
    myPrint('حفظ الملف بنجاح تم ');
  }

  @override
  Future<List<RecordModel>> getAllRecordings() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = appDocDir.listSync(); // كل الملفات
    // فلترة الملفات التي تنتهي بـ .aac (أو أي امتداد آخر للتسجيلات)
    List<FileSystemEntity> recordings =
        files.where((file) {
          return file.path.endsWith('.aac'); // تأكد من أن الامتداد صحيح
        }).toList();

    // تحويل قائمة الملفات إلى RecordModel
    List<RecordModel> recordModels =
        recordings.map((file) {
          myPrint('myFilePath${file}');
          String path = file.path;
          String title = path.split('/').last; // يمكنك تخصيص عنوان الملف هنا
          String description =
              'وصف للتسجيل'; // يمكنك تخصيص الوصف بناءً على ما تحتاجه
          DateTime time = DateTime.fromMillisecondsSinceEpoch(
            int.parse(path.split('_').last.split('.').first),
          );

          return RecordModel(
            recordPath: path,
            title: title,
            description: description,
            time: time,
          );
        }).toList();

    return recordModels;
  }
}

/*
Future<void> startRecord(RecordModel dataModel) async {
  await _newVoiceNoteRepo.checkPermission();

  // Initialize the Record instance
  final record = Record();

  try {
    // Check if recording is supported
    bool hasPermission = await record.hasPermission();
    if (!hasPermission) {
      myPrint('Recording permission denied!');
      return;
    }

    // Start recording
    await record.start(
      path: dataModel.recordPath,
      encoder: AudioEncoder.aacLc, // Equivalent to AAC ADTS in flutter_sound
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
    await Future.delayed(Duration(seconds: 3));
    myPrint('finished timer');

    // Stop recording
    String? result = await record.stop();
    myPrint('Recording stopped. Path: $result'); // Print the output path
  } catch (e) {
    myPrint('Err:$e');
  } finally {
    // Dispose of the record instance to free resources
    await record.dispose();
  }
}
 */
