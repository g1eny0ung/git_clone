import 'package:test/test.dart';
import 'package:git_clone/git_clone.dart';
import 'dart:io';

void main() {
  tearDown(() {
    Process.run('rm', ['-rf', 'blank-from-bitbucket']);
  });

  test('fastClone clones g1eny0ung/blank on Bitbucket', () async {
    await fastClone(
      platform: Platform.bitbucket,
      ownerAndRepo: 'g1eny0ung/blank',
      directory: 'blank-from-bitbucket',
    );

    final destination = Directory('blank-from-bitbucket');
    final isThere = await destination.exists();

    expect(isThere, isTrue);
  });
}
