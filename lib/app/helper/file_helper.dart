import 'dart:io';
import 'dart:math';

mixin FileHelper {
  static String getFileSize(String filepath, int decimals) {
    final file = File(filepath);
    final bytes = file.lengthSync();
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  static double getFileSizeInMb(String filepath, int decimals) {
    final file = File(filepath);
    final bytes = file.lengthSync();
    if (bytes <= 0) return 0;
    return pow(bytes / (1024 * 1024), 2).toDouble();
  }
}
