import 'package:html/parser.dart';

extension HtmlExtensions on String {
  String get parseHtmlString {
    final document = parse(this);
    final parsedString = parse(document.body?.text ?? '').documentElement?.text ?? '';

    return parsedString;
  }
}
