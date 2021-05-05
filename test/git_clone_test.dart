import 'dart:io';
import 'package:git_clone/git_clone.dart';
import 'package:test/test.dart';

void main() {
  group('Run gitClone with different parameters', () {
    tearDownAll(() {
      Process.run('rm', [
        '-rf',
        'git_clone',
        'git-clone',
        'git_clone.git',
        'git-clone-bare-false'
      ]);
    });

    test('Only repo', () {
      gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        callback: (_) async {
          final destination = Directory('git_clone');
          final isThere = await destination.exists();

          expect(isThere, true);
        },
      );
    });

    test('Repo and target directory', () async {
      gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        directory: 'git-clone',
        callback: (_) async {
          final destination = Directory('git-clone');
          final isThere = await destination.exists();

          expect(isThere, true);
        },
      );
    });

    test('With bare option', () async {
      gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        options: {
          '--bare': true,
        },
        callback: (_) async {
          final destination = Directory('git-clone');
          final isThere = await destination.exists();

          expect(isThere, true);
        },
      );
    });

    test('False option', () async {
      gitClone(
        repo: 'https://github.com/g1eny0ung/git_clone.git',
        directory: 'git-clone-bare-false',
        options: {
          '--bare': false,
        },
        callback: (_) async {
          final destination = File('git-clone-bare-false/config');
          final isThere = await destination.exists();

          expect(isThere, false);
        },
      );
    });
  });
}
