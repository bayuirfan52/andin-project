extension FileExtensions on String? {
  bool get isVideo => this!.contains('mp4') || this!.contains('avi') || this!.contains('wmv') || this!.contains('rmvb') || this!.contains('mpg') || this!.contains('mpeg') || this!.contains('3gp');

  bool get isImage => this!.contains('jpg') || this!.contains('jpeg') || this!.contains('png') || this!.contains('gif') || this!.contains('bmp');

  bool get isDoc =>
      this!.contains('xls') ||
      this!.contains('excel') ||
      this!.contains('officedocument.spreadsheetml.sheet') ||
      this!.contains('ppt') ||
      this!.contains('powerpoint') ||
      this!.contains('officedocument.presentationml.presentation') ||
      this!.contains('doc') ||
      this!.contains('msword') ||
      this!.contains('officedocument.wordprocessingml.document') ||
      this!.contains('pdf');
}
