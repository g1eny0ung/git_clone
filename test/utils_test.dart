import 'package:test/test.dart';
import 'package:git_clone/src/utils.dart';

void main() {
  test('Platform.github.parseUri() returns a https url', () {
    expect(Platform.github.parseUri('g1eny0ung/git_clone'),
        equals('https://github.com/g1eny0ung/git_clone.git'));
  });

  test('Platform.github.parseUri() with git remote protocol', () {
    expect(Platform.github.parseUri('g1eny0ung/git_clone', Protocol.git),
        equals('git@github.com:g1eny0ung/git_clone.git'));
  });
}
