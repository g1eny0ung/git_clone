import 'dart:io';
import 'package:git_clone/git_clone.dart';
import 'package:test/test.dart';

void main() {
  group('Runs gitClone with different parameters:', () {
    final repo = 'https://github.com/g1eny0ung/blank.git';

    tearDownAll(() {
      Process.run(
        'rm',
        ['-rf', 'blank', 'blank-project', 'blank.git', 'blank-bare-false'],
      );
    });

    test('only repo', () async {
      await gitClone(
        repo: repo,
        callback: (_) async {
          final destination = Directory('blank');
          final isThere = await destination.exists();

          expect(isThere, isTrue);
        },
      );
    });

    test('repo and target directory', () async {
      await gitClone(
        repo: repo,
        directory: 'blank-project',
        callback: (_) async {
          final destination = Directory('blank-project');
          final isThere = await destination.exists();

          expect(isThere, isTrue);
        },
      );
    });

    test('with --bare', () async {
      await gitClone(
        repo: repo,
        options: {
          '--bare': true,
        },
        callback: (_) async {
          final head = File('blank.git/HEAD');
          final isThere = await head.exists();

          expect(isThere, isTrue);
        },
      );
    });

    test('with --bare false', () async {
      await gitClone(
        repo: repo,
        directory: 'blank-bare-false',
        options: {
          '--bare': false,
        },
        callback: (_) async {
          final head = File('blank-bare-false/head');
          final isThere = await head.exists();

          expect(isThere, isFalse);
        },
      );
    });
  });
}
