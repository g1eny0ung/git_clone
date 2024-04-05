import 'dart:io';
import 'package:git_clone/git_clone.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() => File('git_clone-master.zip').delete());

  test('download git_clone master archive', () async {
    await gitCloneArchive(
      url:
          'https://github.com/g1eny0ung/git_clone/archive/refs/heads/master.zip',
      destination: 'git_clone-master.zip',
    );

    final destination = File('git_clone-master.zip');
    final isThere = await destination.exists();

    expect(isThere, isTrue);
  });
}
