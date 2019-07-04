import 'data_constants.dart';

class DataUtil {

  static String getIntroMedFileName() {
    return _plusFileExt(DataConstants.FILE_NAME_INTRO_MEDITATION);
  }

  static String getBackgroundFileName() {
    return _plusFileExt(DataConstants.FILE_NAME_BACKGROUND);
  }

  static String getMedDescriptionFileName(String medKey) {
    return _plusFileExt('$medKey/${DataConstants.FILE_NAME_DESCRIPTION}');
  }
  static String getMedReminderFileName(String medKey, int num) {
    return _plusFileExt('$medKey/${DataConstants.FILE_NAME_REMINDER}$num');
  }

  static String _plusFileExt(String fileName) => '$fileName.mp3';
}