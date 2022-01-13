import 'dart:io';
import 'package:git_clone/git_clone.dart';
import 'package:test/test.dart';

void main() {
  group('Runs gitClone with different parameters:', () {
    tearDownAll(() {
      Process.run('rm', [
        '-rf',
        'git_clone',
        'git-clone',
        'git_clone.git',
        'git-clone-bare-false'
      ]);
    });

    test('only repo', () async {
      await gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        callback: (_) async {
          final destination = Directory('git_clone');
          final isThere = await destination.exists();

          expect(isThere, isTrue);
        },
      );
    });

    test('repo and target directory', () async {
      await gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        directory: 'git-clone',
        callback: (_) async {
          final destination = Directory('git-clone');
          final isThere = await destination.exists();

          expect(isThere, isTrue);
        },
      );
    });

    test('with --bare', () async {
      await gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        options: {
          '--bare': true,
        },
        callback: (_) async {
          final head = File('git_clone.git/HEAD');
          final isThere = await head.exists();

          expect(isThere, isTrue);
        },
      );
    });

    test('with --bare false', () async {
      await gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        directory: 'git-clone-bare-false',
        options: {
          '--bare': false,
        },
        callback: (_) async {
          final head = File('git-clone-bare-false/head');
          final isThere = await head.exists();

          expect(isThere, isFalse);
        },
      );
    });
  });
}
