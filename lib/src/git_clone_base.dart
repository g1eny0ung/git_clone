import 'dart:io';

typedef Callback = Future<void> Function(ProcessResult);

/// Supported platforms
enum Platform { github, gitlab, bitbucket }

/// Clone a git repository from different [Platform] and [nameAndRepo].
///
/// ```dart
/// fastClone(
///   platform: Platform.github,
///   nameAndRepo: 'g1eny0ung/git_clone',
/// )
/// ```
void fastClone(
    {required Platform platform,
    required String nameAndRepo,
    String? directory,
    Map<String, dynamic>? options,
    Callback? callback}) {
  // Need to implement fastClone
}

/// Clone a git repository by [repo] and target [directory].
///
/// The [options] is synonymous with `git clone` options.
/// If an option has no value, it's needed to pass `true` as a placeholder.
///
/// The [callback] is a [Callback] function which receives clone [ProcessResult] as the argument.
///
/// ```dart
/// gitClone(
///   repo: 'https://github.com/g1eny0ung/git_clone.git',
///   callback: (_) async {
///     final destination = Directory('git_clone');
///     final isThere = await destination.exists();
///
///     print(isThere ? 'Cloned' : 'Failed to clone');
///   },
/// );
/// ```
Future<void> gitClone(
    {required String repo,
    String? directory,
    Map<String, dynamic>? options,
    Callback? callback}) async {
  final args = [];

  if (options != null) {
    options.forEach((key, value) {
      args.add(key);

      if (value is! bool) {
        args.add(value);
      } else if (!value) {
        // Removes false arg from args.
        args.removeLast();
      }
    });
  }

  final result = await Process.run(
      'git', ['clone', ...args, '--', repo, if (directory != null) directory]);

  if (callback != null) {
    await callback(result);
  }
}
