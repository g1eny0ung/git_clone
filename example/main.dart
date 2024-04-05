import 'package:git_clone/git_clone.dart';

void main() {
  gitClone(repo: 'https://github.com/g1eny0ung/git_clone.git');

  // fastClone(platform: Platform.github, ownerAndRepo: 'g1eny0ung/git_clone');

  // gitCloneArchive(
  //   url: 'https://github.com/g1eny0ung/git_clone/archive/refs/heads/master.zip',
  //   destination: 'git_clone-master.zip',
  // );
}
