/// A library for cloning a git repository.
///
/// There are two base functions the library provides:
///
/// - `gitClone()`: Clone a repository via repo link.
/// - `fastClone()`: Clone a repository through different [Platform]s.
///
/// In most cases, all you need is [fastClone],
/// which makes it easy to clone a repository from different platforms like GitHub, GitLab.
/// But if you want to clone a repository from a private git server, you should use [gitClone].
library git_clone;

export 'src/git_clone_base.dart';
export 'src/utils.dart';
