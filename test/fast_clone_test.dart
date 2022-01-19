import 'package:test/test.dart';
import 'package:git_clone/git_clone.dart';
import 'dart:io';

void main() {
  tearDown(() {
    Process.run('rm', ['-rf', 'blank']);
  });

  test('fastClone clones g1eny0ung/blank on Bitbucket', () async {
    await fastClone(
        platform: Platform.bitbucket,
        ownerAndRepo: 'g1eny0ung/blank',
        callback: (_) async {
          final destination = Directory('blank');
          final isThere = await destination.exists();

          expect(isThere, isTrue);
        });
  });
}
