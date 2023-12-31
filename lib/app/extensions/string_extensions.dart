// ignore_for_file: noop_primitive_operations, use_raw_strings

import 'dart:convert';
import 'dart:math';

import 'package:html/parser.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension HtmlExtensions on String {
  String get parseHtmlString {
    final document = parse(this);
    final parsedString = parse(document.body?.text ?? '').documentElement?.text ?? '';

    return parsedString;
  }
}

///   created               : Aditya Pratama
///   originalFilename      : string_extension
///   date                  : 19 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///
enum DocumentType { xls, doc, ppt, pdf, file }

extension MiscExtensions on String? {
  /// input = aditya pratama | output = aditya
  String? get firstWord {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }

    final wordList = this!.split(' ');
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return ' ';
    }
  }

  /// input = aditya pratama | output = AP
  String get initialName {
    final splitW = this!.split(' ');
    var output = '';

    try {
      if (splitW.length > 1) {
        final fWord = splitW[0].substring(0, 1).toUpperCase();
        final sWord = splitW[1].substring(0, 1).toUpperCase();
        output = fWord + sWord;
      } else {
        final fWord = splitW[0].substring(0, 1).toUpperCase();
        output = fWord;
      }
    } catch (_) {
      output = '-';
    }
    return output;
  }

  /// Checks if the [length!] of the String is more than [s].
  bool? operator >(String s) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.length > s.length;
  }

  /// Checks if the [length!] of the String is more or equal to [s].
  bool? operator >=(String s) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.length >= s.length;
  }

  /// Checks if the [length!] of the String is less than [s].
  bool? operator <(String s) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.length < s.length;
  }

  /// Checks if the [length!] of the String is less or equal to [s].
  bool? operator <=(String s) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.length <= s.length;
  }

  /// Subtracts-removes a text from a `String`.
  String? operator -(String s) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    return this!.replaceAll(s, '');
  }

  /// Returns the average read time duration of the given String in seconds.
  ///
  /// The default calculation is based on 200 words per minute.
  ///
  /// You can pass the [wordsPerMinute] parameter for different read speeds.
  /// ### Example
  /// ```dart
  /// String foo =  'Hello dear friend how you doing ?';
  /// int readTime = foo.readTime(); // returns 3 seconds.
  /// ```
  int? readTime({int wordsPerMinute = 200}) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return 0;
    }
    final words = this!.trim().split(RegExp(r'(\s+)'));
    final magicalNumber = words.length / wordsPerMinute;
    return (magicalNumber * 100).toInt();
  }

  /// Capitalizes the string in normal form.
  /// ### Example
  /// ```dart
  /// String foo = 'hAckErrR';
  /// String cFoo = foo.capitalize; // returns 'Hackerrr'.
  /// ```
  String? get capitalize {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
  }

  /// Returns the word count in the given string.
  ///
  /// The pattern is based on spaces.
  /// ### Example
  /// ```dart
  /// String foo = 'Hello dear friend how you doing ?';
  /// int count = foo.countWords; // returns 6 words.
  /// ```
  int? get countWords {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return 0;
    }
    final words = this!.trim().split(RegExp(r'(\s+)'));
    // We filter out symbols and numbers from the word count
    final filteredWords = words.where((e) => e.onlyLatin!.isNotEmpty);
    return filteredWords.length;
  }

  /// Removes only the numbers from the String.
  /// ### Example 1
  /// ```dart
  /// String foo = 'es4e5523nt1is';
  /// String noNumbers = foo.removeNumbers; // returns 'esentis'
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = '1244e*s*4e*5523n*t*1i*s';
  /// String noNumbers = foo.removeNumbers; // returns 'e*s*e*n*t*i*s'
  /// ```
  String? get removeNumbers {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final regex = RegExp(r'(\d+)');
    return this!.replaceAll(regex, '');
  }

  /// Returns only the Latin characters from the String.
  /// ### Example
  /// ```dart
  /// String foo = '4*%^55/es4e5523nt1is';
  /// String onlyLatin = foo.onlyLatin; // returns 'esentis'
  /// ```
  String? get onlyLatin {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    // ignore: unnecessary_raw_strings
    final regex = RegExp(r'([^a-zA-Z\s]+)');
    return this!.replaceAll(regex, '');
  }

  /// Returns only the Greek characters from the String.
  /// ### Example
  /// ```dart
  /// String foo = '4*%^55/σοφ4e5523ια';
  /// String onlyGreek = foo.onlyGreek; // returns 'σοφια'
  /// String foo2 = '4*%^55/σοφ4e5523ια aaggαγάπ112η';
  /// String onlyGreek2 = foo2.onlyGreek; // returns 'σοφια αγάπη'
  /// ```
  String? get onlyGreek {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    // ignore: unnecessary_raw_strings
    final regex = RegExp(r'([^α-ωΑ-ΩίϊΐόάέύϋΰήώΊΪΌΆΈΎΫΉΏ\s]+)');
    return this!.replaceAll(regex, '');
  }

  /// Checks whether the `String` is `null`.
  /// ### Example 1
  /// ```dart
  /// String? foo;
  /// bool isNull = foo.isNull; // returns true
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = 'fff';
  /// bool isNull = foo.isNull; // returns false
  /// ```
  bool get isNull {
    return this == null;
  }

  /// Checks whether the String is valid IPv4.
  /// ### Example 1
  /// ```dart
  /// String foo = '192.168.1.14';
  /// bool isIpv4 = foo.isIpv4; // returns true
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = '192.168.1.14.150.1225';
  /// bool isIpv4 = foo.isIpv4; // returns false
  /// ```
  bool? get isIpv4 {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    final regex = RegExp(
      r'((?:^|\s)([a-z]{3,6}(?=://))?(://)?((?:25[0-5]|2[0-4]\d|[01]?\d\d?)\.(?:25[0-5]|2[0-4]\d|[01]?\d\d?)\.(?:25[0-5]|2[0-4]\d|[01]?\d\d?)\.(?:25[0-5]|2[0-4]\d|[01]?\d\d?))(?::(\d{2,5}))?(?:\s|$))',
    );
    return regex.hasMatch(this!);
  }

  /// Checks whether the String is valid IPv6.
  /// ### Example 1
  /// ```dart
  /// String foo = '2001:0db8:85a3:0000:0000:8a2e:0370:7334';
  /// bool isIpv6 = foo.isIpv6; // returns true
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = '192.168.1.14.150.1225';
  /// bool isIpv6 = foo.isIpv6; // returns false
  /// ```
  bool? get isIpv6 {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }

    this!.substring(0, 1);
    final regex = RegExp(
      r'(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))',
    );
    return regex.hasMatch(this!);
  }

  /// Checks whether the String is valid URL.
  /// ### Example 1
  /// ```dart
  /// String foo = 'foo.1com';
  /// bool isUrl = foo.isUrl; // returns false
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = 'google.com';
  /// bool isUrl = foo.isUrl; // returns true
  /// ```
  bool? get isUrl {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    final regex = RegExp(r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)');
    return regex.hasMatch(this!);
  }

  /// Checks whether the String is valid Date:
  ///
  /// ### Valid formats
  ///
  /// * dd/mm/yyyy
  /// * dd-mm-yyyyy
  /// * dd.mm.yyyy
  /// * yyyy-mm-dd
  /// * yyyy-mm-dd hrs
  /// * 20120227 13:27:00
  /// * 20120227T132700
  /// * 20120227
  /// * +20120227
  /// * 2012-02-27T14Z
  /// * 2012-02-27T14+00:00
  /// * -123450101 00:00:00 Z": in the year -12345
  /// * 2002-02-27T14:00:00-0500": Same as "2002-02-27T19:00:00Z
  bool? get isDate {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    final regex = RegExp(
      r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$',
    );
    if (regex.hasMatch(this!)) {
      return true;
    }
    try {
      DateTime.parse(this!);
      return true;
    } on FormatException {
      return false;
    }
  }

  /// Checks whether the String is a valid mail.
  /// ### Example
  /// ```dart
  /// String foo = 'esentis@esentis.com';
  /// bool isMail = foo.isMail; // returns true
  /// ```
  bool? get isMail {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    final regex = RegExp(r"(^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$)");
    return regex.hasMatch(this!);
  }

  /// Checks whether the String is a number.
  /// ### Example
  /// ```dart
  /// String foo = '45';
  /// bool isNumber = foo.isNumber; // returns true
  /// ```
  /// ```dart
  /// String foo = '45s';
  /// String isNumber = foo.isNumber; // returns false
  bool? get isNumber {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    return num.tryParse(this!) != null;
  }

  /// Checks whether the String is a "strong" password which complies to below rules :
  ///  * At least 1 uppercase
  ///  * At least 1 special character
  ///  * At least 1 number
  ///  * At least 8 characters in length
  /// ### Example
  /// ```dart
  /// String foo = 'qwerty';
  /// bool isStrong = foo.isStrongPassword; // returns false
  /// ```
  /// ```dart
  /// String foo = 'IsTh!$Strong';
  /// bool isStrong = foo.isStrongPassword; // returns true
  /// ```
  bool? get isStrongPassword {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    final regex = RegExp(r'^(?=.*([A-Z]){1,})(?=.*[!@#$&*]{1,})(?=.*[0-9]{1,})(?=.*[a-z]{1,}).{8,100}$');
    return regex.hasMatch(this!);
  }

  /// Checks whether the String is a valid Guid.
  ///
  /// ### Example
  /// ```dart
  /// String foo = '6d64-4396-8547-1ec1b86e081e';
  /// bool isGuid = foo.isGuid; // returns false
  /// ```
  /// ```dart
  /// String foo = '887b7923-6d64-4396-8547-1ec1b86e081e';
  /// bool isGuid = foo.isGuid; // returns true
  /// ```
  bool? get isGuid {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    final regex = RegExp(r'^(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1})$');
    return regex.hasMatch(this!);
  }

  /// Checks if the String exists in a given `Iterable<String>`
  /// ### Example
  /// ```dart
  /// String foo = '6d64-4396-8547-1ec1b86e081e';
  /// var iterable = ['fff','gasd'];
  /// bool isIn = foo.isIn(iterable); // returns false
  /// ```
  bool? isIn(Iterable<String?> strings) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    return strings.contains(this);
  }

  /// Checks if the String has only Latin characters.
  /// ### Example
  /// ```dart
  /// String foo = 'this is a τεστ';
  /// bool isLatin = foo.isLatin; // returns false
  /// String foo2 = 'this is hello world';
  /// bool isLatin2 = foo2.isLatin; // returns true
  /// ```
  bool? get isLatin {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(this!);
  }

  /// Checks if the String has only Greek characters.
  /// ### Example
  /// ```dart
  /// String foo = 'this is a τεστ';
  /// bool isLatin = foo.isGreek; // returns false
  /// String foo2 = 'Τα αγαθά κόποις κτώνται';
  /// bool isLatin2 = foo2.isGreek; // returns true
  /// ```
  bool? get isGreek {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    return RegExp(r'^[α-ωΑ-ΩίϊΐόάέύϋΰήώΊΪΌΆΈΎΫΉΏ\s]+$').hasMatch(this!);
  }

  /// Returns only the numbers from the String.
  /// ### Example
  /// ```dart
  /// String foo = '4*%^55/es4e5523nt1is';
  /// String onyNumbers = foo.onlyNumbers; // returns '455455231'
  /// ```
  String? get onlyNumbers {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    // ignore: unnecessary_raw_strings
    final regex = RegExp(r'([^0-9]+)');
    return this!.replaceAll(regex, '');
  }

  /// Removes only the letters from the String.
  /// ### Example 1
  /// ```dart
  /// String foo = 'es4e5523nt1is';
  /// String noLetters = foo.removeLetters; // returns '455231'
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = '1244e*s*4e*5523n*t*1i*s';
  /// String noLetters = foo.removeLetters; // returns '1244**4*5523**1*'
  /// ```
  String? get removeLetters {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    // ignore: unnecessary_raw_strings
    final regex = RegExp(r'([a-zA-Z]+)');
    return this!.replaceAll(regex, '');
  }

  /// Finds all character ooccurences and returns count as:
  /// ```dart
  /// List<Map<dynamic,dynamic>>
  /// ```
  /// ### Example 1
  /// ```dart
  /// String foo = 'esentis';
  /// List occurences = foo.charOccurences; // returns '[{e:2},{i:1},{n:1},{s:2},]'
  /// ```
  List<Map<String, int>>? get charOccurences {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return [];
    }
    // ignore: omit_local_variable_types
    final List<Map<String, int>> occurences = [];
    final letters = this!.split('')..sort();
    var checkingLetter = letters[0];
    var count = 0;
    for (var i = 0; i < letters.length; i++) {
      if (letters[i] == checkingLetter) {
        count++;
        if (i == letters.length - 1) {
          occurences.add({checkingLetter: count});
          checkingLetter = letters[i];
        }
      } else {
        occurences.add({checkingLetter: count});
        checkingLetter = letters[i];
        count = 1;
      }
    }
    return occurences;
  }

  /// Finds a specific's character occurence in a string.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'foo';
  /// int occ = foo.charCount('o'); // returns 2
  /// ```
  int? charCount(String char) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return 0;
    }
    return this!.split('').fold<int>(0, (previousValue, ch) => previousValue + (ch == char ? 1 : 0));
  }

  /// Finds the most frequent character in the String.
  /// ### Example 1
  /// ```dart
  /// String foo = 'Hello World';
  /// String mostFrequent = foo.mostFrequent; // returns 'l'
  /// ```
  String? get mostFrequent {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final occurrences = <dynamic>[];
    final letters = this!.split('')..sort();
    var checkingLetter = letters[0];
    var count = 0;
    for (var i = 0; i < letters.length; i++) {
      if (letters[i] == checkingLetter) {
        count++;
        if (i == letters.length - 1) {
          occurrences.add({checkingLetter: count});
          checkingLetter = letters[i];
        }
      } else {
        occurrences.add({checkingLetter: count});
        checkingLetter = letters[i];
        count = 1;
      }
    }
    var mostFrequent = '';
    var occursCount = -1;
    for (final element in occurrences) {
      element.forEach((String character, int occurs) {
        if (occurs > occursCount) {
          mostFrequent = character;
          occursCount = occurs;
        }
      });
    }
    return mostFrequent;
  }

  /// Returns the String reversed.
  /// ### Example
  /// ```dart
  /// String foo = 'Hello World';
  /// String reversed = foo.reverse; // returns 'dlrow olleH'
  /// ```
  String? get reverse {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final letters = this!.split('').toList().reversed;
    return letters.reduce((current, next) => current + next);
  }

  /// Returns the first [n] characters of the string.
  ///
  /// n is optional, by default it returns the first character of the string.
  ///
  /// If [n] provided is longer than the string's length, the string will be returned.
  ///
  /// Faster than using
  /// ```dart
  /// substring(0,count)
  /// ```
  /// ### Example 1
  /// ```dart
  /// String foo = 'hello world';
  /// String firstChars = foo.first(); // returns 'h'
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = 'hello world';
  /// bool firstChars = foo.first(3); // returns 'hel'
  /// ```
  String? first({int n = 1}) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (this!.length < n) {
      return this;
    }
    return this!.substring(0, n);
  }

  /// Returns the last [n] characters of the string.
  ///
  /// [n] is optional, by default it returns the first character of the string.
  ///
  /// If [n] provided is longer than the string's length, the string will be returned.
  ///
  /// Faster than using
  /// ```dart
  /// substring(length-n,length)
  /// ```
  /// ### Example 1
  /// ```dart
  /// String foo = 'hello world';
  /// String firstChars = foo.last(); // returns 'd'
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = 'hello world';
  /// bool firstChars = foo.last(3); // returns 'rld'
  /// ```
  String? last({int n = 1}) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (this!.length < n) {
      return this;
    }
    return this!.substring(this!.length - n, this!.length);
  }

  /// Returns the string to slug case.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'hello world';
  /// String fooSlug = foo.toSlug; // returns 'hello_world'
  /// ```
  String? get toSlug {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final words = this!.trim().split(RegExp(r'(\s+)'));
    var slugWord = '';
    if (this!.length == 1) {
      return this;
    }
    for (var i = 0; i <= words.length - 1; i++) {
      if (i == words.length - 1) {
        slugWord += words[i];
      } else {
        slugWord += '${words[i]}_';
      }
    }
    return slugWord;
  }

  /// Returns the String in camelcase.
  /// ### Example
  /// ```dart
  /// String foo = 'Find max of array';
  /// String camelCase = foo.toCamelCase; // returns 'findMaxOfArray'
  /// ```
  String? get toCamelCase {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final words = this!.trim().split(RegExp(r'(\s+)'));
    final result = StringBuffer();
    result.write(words[0].toLowerCase());
    for (var i = 1; i < words.length; i++) {
      result.write(words[i].substring(0, 1).toUpperCase() + words[i].substring(1).toLowerCase());
    }
    return result.toString();
  }

  /// Returns the word title cased.
  ///
  /// ```dart
  /// String foo = 'Hello dear friend how you doing ?';
  /// Sting titleCased = foo.toTitleCase; // returns 'Hello Dear Friend How You Doing'.
  /// ```
  String? get toTitleCase {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final words = this!.toLowerCase().split(' ');
    for (var i = 0; i < words.length; i++) {
      words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }

  /// Returns a list of the string's characters.
  ///
  /// O(n)
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'abracadabra';
  /// List<String> fooArray = foo.toArray; // returns '[a,b,r,a,c,a,d,a,b,r,a]'
  /// ```
  List<String>? get toArray {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return [];
    }
    return this!.split('');
  }

  /// Converts a `string` to a numeric value if possible.
  ///
  /// If conversion fails, `null` is returned.
  ///
  /// ### Example
  /// ```dart
  /// String foo = '4';
  /// int fooInt = foo.toNum(); // returns 4;
  /// ```
  /// ```dart
  /// String foo = '4f';
  /// var fooNull = foo.toNum(); // returns null;
  /// ```
  num? toNum() {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    return num.tryParse(this!);
  }

  /// Converts a `string` to`int` if possible.
  ///
  /// If conversion fails, `null` is returned.
  ///
  /// ### Example
  /// ```dart
  /// String foo = '4';
  /// int fooInt = foo.toInt(); // returns 4;
  /// ```
  /// ```dart
  /// String foo = '4f';
  /// var fooNull = foo.toInt(); // returns null;
  /// ```
  /// ```dart
  /// String foo = '4.0';
  /// var fooNull = foo.toInt(); // returns 4;
  /// ```
  int? toInt() {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    return int.tryParse(this!) ?? double.tryParse(this!)?.floor();
  }

  /// Converts a `string` to`double` if possible.
  ///
  /// If conversion fails, `null` is returned.
  ///
  /// ### Example
  /// ```dart
  /// String foo = '4';
  /// int fooInt = foo.toDouble(); // returns 4.0;
  /// ```
  /// ```dart
  /// String foo = '4f';
  /// var fooNull = foo.toDouble(); // returns null;
  /// ```
  double? toDouble() {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    return double.tryParse(this!);
  }

  /// Replaces all greek words with latin. Comes handy when you want to normalize text for search.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'Αριστοτέλης';
  /// String fooReplaced = foo.replaceGreek; // returns 'aristotelis'
  /// ```
  String? get replaceGreek {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final normalizedWord = this!
        .replaceAll(RegExp(r'\ευ'), 'ef')
        .replaceAll(RegExp(r'\εύ'), 'ef')
        .replaceAll(RegExp(r'\αυ'), 'av')
        .replaceAll(RegExp(r'\αύ'), 'av')
        .replaceAll(RegExp(r'\α'), 'a')
        .replaceAll(RegExp(r'\ά'), 'a')
        .replaceAll(RegExp(r'\Α'), 'a')
        .replaceAll(RegExp(r'\Ά'), 'a')
        .replaceAll(RegExp(r'\β'), 'v')
        .replaceAll(RegExp(r'\Β'), 'v')
        .replaceAll(RegExp(r'\γ'), 'g')
        .replaceAll(RegExp(r'\Γ'), 'g')
        .replaceAll(RegExp(r'\δ'), 'd')
        .replaceAll(RegExp(r'\Δ'), 'd')
        .replaceAll(RegExp(r'\ε'), 'e')
        .replaceAll(RegExp(r'\έ'), 'e')
        .replaceAll(RegExp(r'\Έ'), 'e')
        .replaceAll(RegExp(r'\Ε'), 'e')
        .replaceAll(RegExp(r'\ζ'), 'z')
        .replaceAll(RegExp(r'\Ζ'), 'z')
        .replaceAll(RegExp(r'\ι'), 'i')
        .replaceAll(RegExp(r'\Η'), 'i')
        .replaceAll(RegExp(r'\Ή'), 'i')
        .replaceAll(RegExp(r'\η'), 'i')
        .replaceAll(RegExp(r'\ή'), 'i')
        .replaceAll(RegExp(r'\ί'), 'i')
        .replaceAll(RegExp(r'\ϊ'), 'i')
        .replaceAll(RegExp(r'\ΐ'), 'i')
        .replaceAll(RegExp(r'\Ι'), 'i')
        .replaceAll(RegExp(r'\Ί'), 'i')
        .replaceAll(RegExp(r'\Ϊ'), 'i')
        .replaceAll(RegExp(r'\κ'), 'k')
        .replaceAll(RegExp(r'\Κ'), 'k')
        .replaceAll(RegExp(r'\λ'), 'l')
        .replaceAll(RegExp(r'\Λ'), 'l')
        .replaceAll(RegExp(r'\μ'), 'm')
        .replaceAll(RegExp(r'\Μ'), 'm')
        .replaceAll(RegExp(r'\ξ'), 'ks')
        .replaceAll(RegExp(r'\Ξ'), 'ks')
        .replaceAll(RegExp(r'\ο'), 'o')
        .replaceAll(RegExp(r'\ό'), 'o')
        .replaceAll(RegExp(r'\Ό'), 'o')
        .replaceAll(RegExp(r'\Ο'), 'o')
        .replaceAll(RegExp(r'\π'), 'p')
        .replaceAll(RegExp(r'\Π'), 'p')
        .replaceAll(RegExp(r'\ρ'), 'r')
        .replaceAll(RegExp(r'\Ρ'), 'r')
        .replaceAll(RegExp(r'\σ'), 's')
        .replaceAll(RegExp(r'\Σ'), 's')
        .replaceAll(RegExp(r'\ς'), 's')
        .replaceAll(RegExp(r'\τ'), 't')
        .replaceAll(RegExp(r'\Τ'), 't')
        .replaceAll(RegExp(r'\υ'), 'y')
        .replaceAll(RegExp(r'\ύ'), 'y')
        .replaceAll(RegExp(r'\ϋ'), 'y')
        .replaceAll(RegExp(r'\ΰ'), 'y')
        .replaceAll(RegExp(r'\Υ'), 'y')
        .replaceAll(RegExp(r'\Ύ'), 'y')
        .replaceAll(RegExp(r'\Ϋ'), 'y')
        .replaceAll(RegExp(r'\φ'), 'f')
        .replaceAll(RegExp(r'\Φ'), 'f')
        .replaceAll(RegExp(r'\χ'), 'ch')
        .replaceAll(RegExp(r'\Χ'), 'ch')
        .replaceAll(RegExp(r'\ψ'), 'ps')
        .replaceAll(RegExp(r'\Ψ'), 'ps')
        .replaceAll(RegExp(r'\ω'), 'o')
        .replaceAll(RegExp(r'\ώ'), 'o')
        .replaceAll(RegExp(r'\Ω'), 'o')
        .replaceAll(RegExp(r'\Ώ'), 'o');
    return normalizedWord;
  }

  /// Given a pattern returns the starting indices of all occurences of the pattern in the string.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'abracadabra';
  /// String fooOccs = foo.findPatterns(pattern:'abr'); // returns '[0, 7]'
  /// ```
  List<int>? findPattern({required String pattern}) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return [];
    }
    // ignore: omit_local_variable_types
    final List<int> occurences = [];
    // How many times the pattern can fit the text provided
    final fitCount = (this!.length / pattern.length).truncate().toInt();
    if (fitCount > this!.length) {
      return [];
    }
    if (fitCount == 1) {
      if (this == pattern) {
        return [0];
      }
      return [];
    }
    for (var i = 0; i <= this!.length; i++) {
      if (i + pattern.length > this!.length) {
        return occurences;
      }
      if (this!.substring(i, i + pattern.length) == pattern) {
        occurences.add(i);
      }
    }
    return occurences;
  }

  /// Strips all HTML code from String.
  ///
  /// ### Example
  /// ```dart
  /// String html = '<script>Hacky hacky.</script> <p>Here is some text. <span class="bold">This is bold. </span></p>';
  /// String stripped = foo.stripHtml; // returns 'Hacky hacky. Here is some text. This is bold.';
  /// ```
  String? get stripHtml {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    // ignore: unnecessary_raw_strings
    final regex = RegExp(r'<[^>]*>');
    return this!.replaceAll(regex, '');
  }

  /// If the provided string is empty do something.
  ///
  /// ### Example
  /// ```dart
  /// String foo = '';
  /// foo.ifEmpty(()=>print('String is empty'));
  /// ```
  dynamic ifEmpty(Function act) {
    if (this == null) {
      return null;
    }
    return this!.isEmpty;
  }

  /// If the provided `String` is `null` do something.
  ///
  /// ### Example
  /// ```dart
  /// String foo = ''
  /// foo.ifEmpty(()=>print('String is null'));
  /// ```
  dynamic ifNull(Function act) {
    if (this != null) {
      return this;
    }
    return act();
  }

  /// Provide default value if the `String` is `null`.
  ///
  /// ### Example
  /// ```dart
  /// String? foo = null;
  /// foo.ifNull('dont be null'); // returns 'dont be null'
  /// ```
  String? defaultValue(String defautlValue) {
    if (this != null) {
      return this;
    }
    return defautlValue;
  }

  /// Repeats a string [count] times.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'foo';
  /// String fooRepeated = foo.repeat(5); // 'foofoofoofoofoo'
  /// ```
  String? repeat(int count) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty || count <= 0) {
      return this;
    }
    final repeated = StringBuffer();
    repeated.write(this);
    for (var i = 0; i < count - 1; i++) {
      repeated.write(this);
    }
    return repeated.toString();
  }

  /// Squeezes the string by removing repeats of a given character.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'foofoofoofoofoo';
  /// String fooSqueezed = foo.squeeze('o'); // 'fofofofofo';
  /// ```
  String? squeeze(String char) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    var sb = '';
    for (var i = 0; i < this!.length; i++) {
      if (i == 0 || this![i - 1] != this![i] || (this![i - 1] == this![i] && this![i] != char)) {
        sb += this![i];
      }
    }
    return sb;
  }

  /// Checks if the string is consisted of same characters (ignores cases).
  ///
  /// ### Example
  /// ```dart
  /// String foo1 = 'ttttttt'
  /// bool hasSame1 = foo.hasSameCharacters(); // true;
  /// ```
  /// ```dart
  /// String foo = 'ttttttt12'
  /// bool hasSame2 = foo.hasSameCharacters();  // false;
  /// ```
  bool? get hasSameCharacters {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return false;
    }
    if (this!.length > 1) {
      final b = this![0].toLowerCase();
      for (var i = 1; i < this!.length; i++) {
        final c = this![i].toLowerCase();
        if (c != b) {
          return false;
        }
      }
    }
    return true;
  }

  /// Shuffles the given string characters.
  ///
  /// ### Example
  /// ```dart
  /// String foo1 = 'esentis';
  /// String shuffled = foo.shuffle; // 'tsniees'
  /// ```
  String? get shuffle {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final stringArray = toArray;
    stringArray!.shuffle();
    return stringArray.join();
  }

  /// The Levenshtein distance between two words is the minimum number of single-character
  ///
  /// edits (insertions, deletions or substitutions) required to change one word into the other.
  ///
  /// ### Example
  /// ```dart
  /// String foo1 = 'esentis';
  /// int dist = foo.getLevenshtein('esentis2'); // 1
  /// ```
  int? getLevenshtein(String b) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    final a = this!.toLowerCase();
    var result = '';
    result = b.toLowerCase();
    // i == 0
    final costs = List.filled(result.length + 1, 0);
    for (var j = 0; j < costs.length; j++) {
      costs[j] = j;
    }
    for (var i = 1; i <= a.length; i++) {
      // j == 0; nw = lev(i - 1, j)
      costs[0] = i;
      var nw = i - 1;
      for (var j = 1; j <= result.length; j++) {
        // ignore: omit_local_variable_types
        final int cj = min(1 + min(costs[j], costs[j - 1]), a[i - 1] == result[j - 1] ? nw : nw + 1);
        nw = costs[j];
        costs[j] = cj;
      }
    }
    return costs[result.length];
  }

  /// Inspired from Vincent van Proosdij
  /// Formats a String with a specific mask.
  ///
  /// You can assign your own [specialChar], defaults to '#'.
  ///
  /// ### Example
  /// ```dart
  ///var string3 = 'esentisgreece';
  ///var mask3 = 'Hello ####### you are from ######';
  ///var masked3 = string3.formatWithMask(mask3); // returns 'Hello esentis you are from greece'
  /// ```
  String? formatWithMask(String mask, {String specialChar = '#'}) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    //var buffer = StringBuffer();
    final maskChars = mask.toArray;
    var index = 0;
    var out = '';
    for (final m in maskChars!) {
      if (m == specialChar) {
        if (index < this!.length) {
          out += this![index];
          index++;
        }
      } else {
        out += m;
      }
    }
    return out;
  }

  /// Removes the first [n] characters of the `String`.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'esentis'
  /// String newFoo = foo.removeFirst(3) // 'ntis';
  /// ```
  String? removeFirst(int n) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (n <= 0) {
      return this;
    }
    if (n >= this!.length) {
      return '';
    }
    return this!.substring(n, this!.length);
  }

  /// Removes the last [n] characters of the `String`.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'esentis';
  /// String newFoo = foo.removeLast(3); // 'esen';
  /// ```
  String? removeLast(int n) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (n <= 0) {
      return this;
    }
    if (n >= this!.length) {
      return '';
    }
    return this!.substring(0, this!.length - n);
  }

  /// Trims the `String` to have maximum [n] characters.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'esentis';
  /// String newFoo = foo.maxChars(3); // 'esen';
  /// ```
  String? maxChars(int n) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (n <= 0) {
      return '';
    }
    if (n >= this!.length) {
      return this;
    }
    return this!.substring(0, n);
  }

  /// Reverses slash by providing [direction],
  ///
  /// `0 = / -> \\`
  ///
  /// `1 = \\-> /`
  ///
  /// ### Example
  /// ```dart
  /// String foo1 = 'C:/Documents/user/test';
  /// String revFoo1 = foo1.reverseSlash(0); // returns 'C:\Documents\user\test'
  ///
  /// String foo2 = 'C:\\Documents\\user\\test';
  /// String revFoo2 = foo1.reverseSlash(1); // returns 'C:/Documents/user/test'
  /// ```
  String? reverseSlash(int direction) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    switch (direction) {
      case 0:
        return this!.replaceAll('/', '\\');
      case 1:
        return this!.replaceAll('\\', '/');
      default:
        return this;
    }
  }

  /// Returns the character at [index].
  ///
  /// ### Example
  ///
  /// ```dart
  /// String foo1 = 'esentis';
  /// String char1 = foo1.charAt(0); // returns 'e'
  /// String char2 = foo1.charAt(4); // returns 'n'
  /// String? char3 = foo1.charAt(-20); // returns null
  /// String? char4 = foo1.charAt(20); // returns null
  /// ```
  String? charAt(int index) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (index > this!.length) {
      return null;
    }
    if (index < 0) {
      return null;
    }
    return this!.split('')[index];
  }

  /// Appends a [suffix] to the `String`.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String foo = 'hello';
  /// String newFoo = foo1.append(' world'); // returns 'hello world'
  /// ```
  String? append(String suffix) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    return this! + suffix;
  }

  /// Prepends a [prefix] to the `String`.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String foo = 'world';
  /// String newFoo = foo1.prepend('hello '); // returns 'hello world'
  /// ```
  String? prepend(String prefix) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    return prefix + this!;
  }

  /// Tries to format the current `String` to price amount. You can pass
  ///
  /// you can optionally pass the [currencySymbol] to append a symbol to the formatted text.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String price = '1234567';
  /// String formattedPrice = foo1.toPriceAmount(currencySymbol: '€'); // returns '12.345,67 €'
  /// ```
  String? toPriceAmount({String? currencySymbol}) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    try {
      final f = NumberFormat.currency(locale: 'el_GR');
      return f.format(double.tryParse(this!.replaceAll(',', '.'))).replaceAll('EUR', '').trim().append(currencySymbol == null ? '' : ' $currencySymbol');
    } catch (e) {
      return null;
    }
  }

  /// Returns the day name of the date provided.
  ///
  /// If the date is in `DateTime` format, you can convert it to `String` `DateTime().toString()`.
  ///
  /// You can provide the [locale] to filter the result to a specific language.
  ///
  /// Defaults to 'en-US'.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String date = '2021-10-23';
  /// String day = date.getDayFromDate(); // returns 'Saturday'
  /// String grDay = date.getDayFromDate(locale:'el'); // returns 'Σάββατο'
  /// ```
  String? getDayFromDate({String locale = 'en'}) {
    initializeDateFormatting(locale);
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final date = DateTime.tryParse(this!);
    if (date == null) {
      return null;
    }
    return DateFormat('EEEE', locale).format(date).toString();
  }

  /// Returns the month name of the date provided.
  ///
  /// If the date is in `DateTime` format, you can convert it to `String` `DateTime().toString()`.
  ///
  /// You can provide the [locale] to filter the result to a specific language.
  ///
  /// Defaults to 'en-US'.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String date = '2021-10-23';
  /// String month = date.getMonthFromDate(); // returns 'August'
  /// String grMonth = date.getMonthFromDate(locale:'el'); // returns 'Αυγούστου'
  /// ```
  String? getMonthFromDate({String locale = 'en'}) {
    initializeDateFormatting(locale);
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final date = DateTime.tryParse(this!);
    if (date == null) {
      return null;
    }
    return DateFormat('MMMM', locale).format(date).toString();
  }

  /// Returns the first day of the month from the provided `DateTime`.
  ///
  /// If the date is in `DateTime` format, you can convert it to `String` `DateTime().toString()`.
  ///
  /// You can provide the [locale] to filter the result to a specific language.
  ///
  /// Defaults to 'en-US'.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String date = '2021-10-23';
  /// String day = date.firstDayOfDate(); // returns 'Friday'
  /// String grDay = date.firstDayOfDate(locale:'el'); // returns 'Παρασκευή'
  /// ```
  String? firstDayOfMonth({String locale = 'en'}) {
    initializeDateFormatting(locale);
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final date = DateTime.tryParse(this!);
    if (date == null) {
      return null;
    }
    return DateFormat('EEEE', locale).format(DateTime(date.year, date.month)).toString();
  }

  /// Returns the last day of the month from the provided `DateTime`.
  ///
  /// If the date is in `DateTime` format, you can convert it to `String` `DateTime().toString()`.
  ///
  /// You can provide the [locale] to filter the result to a specific language.
  ///
  /// Defaults to 'en-US'.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String date = '2021-10-23';
  /// String day = date.firstDayOfDate(); // returns 'Friday'
  /// String grDay = date.firstDayOfDate(locale:'el'); // returns 'Παρασκευή'
  /// ```
  String? lastDayOfMonth({String locale = 'en'}) {
    initializeDateFormatting(locale);
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final date = DateTime.tryParse(this!);
    if (date == null) {
      return null;
    }
    return DateFormat('EEEE', locale)
        .format(
          DateTime(date.year, date.month + 1).add(
            const Duration(days: -1),
          ),
        )
        .toString();
  }

  /// Returns the left side of the `String` starting from [char].
  ///
  /// ### Example
  ///
  /// ```dart
  ///  String s = 'peanutbutter';
  ///  String foo = s.leftOf('butter'); // returns 'peanut'
  /// ```
  String? leftOf(String char) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final index = this!.indexOf(char);
    return this!.substring(0, index);
  }

  /// Returns the right side of the `String` starting from [char].
  ///
  /// ### Example
  ///
  /// ```dart
  ///  String s = 'peanutbutter';
  ///  String foo = s.rightOf('peanut'); // returns 'butter'
  /// ```
  String? rightOf(String char) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final index = this!.indexOf(char);
    return this!.substring(index + char.length, this!.length);
  }

  /// Truncates a `String` with more than `length` characters.
  ///
  /// [length] must be more than 0.
  ///
  /// If [length] > String.length the same `String` is returned without truncation.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String f = 'congratulations';
  /// String truncated = f.truncate(3); // Returns 'con...'
  /// ```
  String? truncate(int length) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (length <= 0) {
      return this;
    }
    if (length > this!.length) {
      return this;
    }
    return '${this!.substring(0, length)}...';
  }

  /// Truncates a long `String` in the middle while retaining the beginning and the end.
  ///
  /// [maxChars] must be more than 0.
  ///
  /// If [maxChars] > String.length the same `String` is returned without truncation.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String f = 'congratulations';
  /// String truncated = f.truncateMiddle(5); // Returns 'con...ns'
  /// ```
  String? truncateMiddle(int maxChars) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (maxChars <= 0) {
      return this;
    }
    if (maxChars > this!.length) {
      return this;
    }
    final leftChars = (maxChars / 2).ceil();
    final rightChars = maxChars - leftChars;
    return '${this!.first(n: leftChars)}...${this!.last(n: rightChars)}';
  }

  /// Quotes the `String` adding "" at the start & at the end.
  ///
  /// Removes all " characters from the `String` before adding the quotes.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String text = '"""Is this real"';
  /// String quote = text.quote; // "Is this real"
  /// ```
  String? get quote {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    final normalizedString = this!.replaceAll('"', '');
    return normalizedString.append('"').prepend('"');
  }

  /// Trims leading and trailing spaces, so as extra spaces in between words.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String text = '    esentis    thinks   ';
  /// String trimmed = text.trimAll ; // returns 'esentis thinks'
  /// ```
  String? get trimAll {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    return this!.trim().replaceAll(RegExp(' +'), ' ');
  }

  dynamic parseJSON({Object? Function(Object? key, Object? value)? reviver}) {
    try {
      if (this == null) {
        return null;
      }
      if (this!.isEmpty) {
        return this;
      }
      return jsonDecode(this!, reviver: reviver);
    } catch (_) {
      throw Exception('🛑 cant parseJSON');
    }
  }

  /// Searches the string for the first occurrence of a [pattern] and returns
  /// everything after that occurrence.
  ///
  /// Returns `''` if no occurrences were found.
  ///
  /// Example:
  /// ```dart
  /// 'value=1'.allAfter('=');                 // '1'
  /// 'i like turtles'.allAfter('like')        // ' turtles'
  /// 'i   like cats'.allAfter(RegExp('\\s+')) // 'like cats'
  /// ```
  String allAfter(Pattern pattern) {
    final matchIterator = pattern.allMatches(this!).iterator;

    if (matchIterator.moveNext()) {
      final match = matchIterator.current;
      final length = match.end - match.start;
      return this!.substring(match.start + length);
    }
    return '';
  }

  /// Searches the string for the last occurrence of a [pattern] and returns
  /// everything before that occurrence.
  ///
  /// Returns `''` if no occurrences were found.
  ///
  /// Example:
  /// ```dart
  /// 'value=1'.allBefore('=');          // 'value'
  /// 'i like turtles'.allBefore('like') // 'i '
  /// ```
  String allBefore(Pattern pattern) {
    final matchIterator = pattern.allMatches(this!).iterator;

    Match? match;
    while (matchIterator.moveNext()) {
      match = matchIterator.current;
    }

    if (match != null) {
      return this!.substring(0, match.start);
    }
    return '';
  }

  /// Searches the string for the first occurrence of [startPattern] and the
  /// last occurrence of [endPattern]. It returns the string between that
  /// occurrences.
  ///
  /// Returns `''` if no occurrences were found.
  ///
  /// Example:
  /// ```dart
  /// 'i like turtles'.allBetween('i ', ' turtles') // 'like'
  /// ```
  String allBetween(Pattern startPattern, Pattern endPattern) {
    return allAfter(startPattern).allBefore(endPattern);
  }

  // —————————————————————————————————————————————————————————————————————————
  // from gredu
  // —————————————————————————————————————————————————————————————————————————
  /// get type document url
  DocumentType get typeDocumentUrl => this!.contains('xls')
      ? DocumentType.xls
      : this!.contains('doc')
          ? DocumentType.doc
          : this!.contains('ppt')
              ? DocumentType.ppt
              : this!.contains('pdf')
                  ? DocumentType.pdf
                  : DocumentType.file;

  /// get icon document
  String get iconDocument => this!.contains('xls')
      ? 'assets/images/ic_xls.svg'
      : this!.contains('doc')
          ? 'assets/images/ic_doc.svg'
          : this!.contains('ppt')
              ? 'assets/images/ic_ppt.svg'
              : this!.contains('pdf')
                  ? 'assets/images/ic_pdf.svg'
                  : 'assets/images/ic_file.svg';

  String convertCurrency() {
    final format = NumberFormat.simpleCurrency(locale: 'in', decimalDigits: 0, name: 'Rp. ');
    return format.format(int.parse(this!));
  }
}

extension NullableStringIsNullOrEmptyExtension on String? {
  /// Returns `true` if the string is either `null` or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;
}

extension NullableStringIsNotNullOrEmptyExtension on String? {
  /// Returns `true` if the string is neither null nor empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
