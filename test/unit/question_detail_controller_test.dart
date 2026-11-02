import 'package:andin_project/app/data/answer.dart';
import 'package:andin_project/app/modules/question/question_detail/question_navigation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('questionIdAtOffset', () {
    const ids = <String?>['first', 'second', 'third'];

    test('returns the adjacent question in either direction', () {
      expect(questionIdAtOffset(ids, 'second', -1), 'first');
      expect(questionIdAtOffset(ids, 'second', 1), 'third');
    });

    test('does not move beyond either end', () {
      expect(questionIdAtOffset(ids, 'first', -1), isNull);
      expect(questionIdAtOffset(ids, 'third', 1), isNull);
    });

    test('returns null for unknown IDs and unsupported offsets', () {
      expect(questionIdAtOffset(ids, 'missing', 1), isNull);
      expect(questionIdAtOffset(ids, 'first', 2), isNull);
    });
  });

  test('Answer constructor retains an explicitly supplied identifier', () {
    expect(Answer(idAnswer: 'answer-1').idAnswer, 'answer-1');
  });
}
