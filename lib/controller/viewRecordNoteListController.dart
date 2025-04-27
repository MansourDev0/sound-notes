import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:sound_notes/repositories/newVoiceNoteRepo.dart';

class ViewRecordNoteListController extends GetxController {
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  // دالة لتشغيل التسجيل
  Future<void> playRecording(String filePath) async {
    try {
      await _audioPlayer.openPlayer();
      await _audioPlayer.startPlayer(
        fromURI: filePath,
        codec: Codec.aacADTS, // تأكد من اختيار الترميز المناسب للتسجيلات لديك
        whenFinished: () {
          print('انتهى تشغيل التسجيل');
        },
      );
      print('التسجيل يتم تشغيله الآن');
    } catch (e) {
      print('فشل في تشغيل التسجيل: $e');
    }
  }

  // دالة لإيقاف التشغيل
  Future<void> stopPlayback() async {
    await _audioPlayer.stopPlayer();
  }

  // دالة لإيقاف الصوت مؤقتًا
  Future<void> pausePlayback() async {
    await _audioPlayer.pausePlayer();
  }

  // دالة لاستئناف التشغيل بعد التوقف المؤقت
  Future<void> resumePlayback() async {
    await _audioPlayer.resumePlayer();
  }

  final NewVoiceNoteRepoImp _newVoiceNoteRepoImp = NewVoiceNoteRepoImp();
  @override
  void onInit() {
    _newVoiceNoteRepoImp.getAllRecordings();

    super.onInit();
  }
}
