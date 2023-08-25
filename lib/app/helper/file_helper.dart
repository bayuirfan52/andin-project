import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:andin_project/app/utils/logger.dart' as logger;

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

  static String getFileExtensions(String pathFile) {
    return path.extension(pathFile);
  }

  static Future<File> copyImageToAppDir(File file) async {
    Directory? dir;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    final imageDir = Directory('${dir?.path}/image');
    if (!imageDir.existsSync()) {
      await imageDir.create();
    }

    logger.logI('Image Dir: ${imageDir.path}');
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final newFile = File('${imageDir.path}/image_$timeStamp${getFileExtensions(file.path)}');
    await newFile.create();
    await newFile.writeAsBytes(file.readAsBytesSync());
    return newFile;
  }
}
