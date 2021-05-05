import 'dart:io';

typedef Callback = void Function(ProcessResult);

/// Clone a git repository by [repo] and target [directory].
///
/// The [options] is synonymous with `git clone` options.
/// If an option has no value, it's needed to pass `true` as a placeholder.
///
/// Pass [callback] function to receive the clone [ProcessResult].
void gitClone(
    {required String repo,
    String? directory,
    Map<String, dynamic>? options,
    Callback? callback}) {
  final args = [];

  if (options != null) {
    options.forEach((key, value) {
      args.add(key);

      if (value is! bool && value) {
        args.add(value);
      }
    });
  }

  Process.run('git', [
    'clone',
    ...args,
    '--',
    repo,
    if (directory != null) directory
  ]).then((result) => {
        if (callback != null) {callback(result)}
      });
}
