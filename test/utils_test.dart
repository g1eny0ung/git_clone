import 'package:test/test.dart';
import 'package:git_clone/git_clone.dart';

void main() {
  test('Platform.github.parseUri() returns correct https url', () {
    expect(Platform.github.parseUri('g1eny0ung/git_clone'),
        equals('https://github.com/g1eny0ung/git_clone.git'));
  });

  test(
      'Platform.github.parseUri() with git remote protocol returns correct git url',
      () {
    expect(Platform.github.parseUri('g1eny0ung/git_clone', Protocol.git),
        equals('git@github.com:g1eny0ung/git_clone.git'));
  });

  test('Platform.bitbucket.parseUri() returns correct https url', () {
    expect(Platform.bitbucket.parseUri('g1eny0ung/blank'),
        equals('https://bitbucket.org/g1eny0ung/blank.git'));
  });
}
