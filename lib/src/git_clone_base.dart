import 'dart:io';

typedef Callback = void Function(ProcessResult);

/// Clone a git repository by [repo] and target [directory].
///
/// The [options] is synonymous with `git clone` options.
/// If an option has no value, it's needed to pass `true` as a placeholder.
///
/// The [callback] is a [Callback] function which receives clone [ProcessResult] as the argument.
void gitClone(
    {required String repo,
    String? directory,
    Map<String, dynamic>? options,
    Callback? callback}) {
  final args = [];

  if (options != null) {
    options.forEach((key, value) {
      args.add(key);

      if (value is! bool) {
        args.add(value);
      } else if (!value) {
        args.removeLast();
      }
    });
  }

  Process.run('git', [
    'clone',
    ...args,
    '--',
    repo,
    if (directory != null) directory
  ]).then((result) {
    if (callback != null) {
      callback(result);
    }
  });
}
