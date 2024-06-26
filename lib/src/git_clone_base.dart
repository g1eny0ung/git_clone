import 'dart:io';
import 'package:http/http.dart' as http;
import 'utils.dart';

typedef Callback = Future<void> Function(ProcessResult);

/// Clone a git repository from [Platform] and [ownerAndRepo] by calling [gitClone].
///
/// You can also change the [protocol] to other supported [Protocol]s. Default is [Protocol.https].
///
/// Example:
///
/// ```dart
/// fastClone(
///   platform: Platform.github,
///   ownerAndRepo: 'g1eny0ung/git_clone',
/// )
/// ```
Future<void> fastClone({
  required Platform platform,
  required String ownerAndRepo,
  Protocol protocol = Protocol.https,
  String? directory,
  Map<String, dynamic>? options,
  Callback? callback,
}) {
  return gitClone(
    repo: platform.parseUri(ownerAndRepo, protocol),
    directory: directory,
    options: options,
    callback: callback,
  );
}

/// Clone a git repository by [repo] and target [directory].
///
/// The [options] is synonymous with `git clone` options.
/// If an option has no value, it's needed to pass `true` as a placeholder.
///
/// The [callback] is a [Callback] function which receives clone [ProcessResult] as the argument.
///
/// Example:
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
Future<void> gitClone({
  required String repo,
  String? directory,
  Map<String, dynamic>? options,
  Callback? callback,
}) async {
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
    'git',
    ['clone', ...args, '--', repo, if (directory != null) directory],
  );

  if (callback != null) {
    await callback(result);
  }
}

/// Download a git repository archive from [url] and save it to [destination].
///
/// Use this function if you haven't installed `git` on your system.
///
/// Note: this function will not extract the archive.
///
/// Example:
///
/// ```dart
/// gitCloneArchive(
///   url: 'https://github.com/g1eny0ung/git_clone/archive/refs/heads/master.zip',
///   destination: 'git_clone-master.zip',
/// );
/// ```
Future<void> gitCloneArchive({
  required String url,
  required String destination,
}) {
  return _downloadFile(url, destination);
}

Future<void> _downloadFile(String url, String savePath) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw GitRepoRetrievalException(url: url, response: response);
  }

  final file = File(savePath);
  await file.writeAsBytes(response.bodyBytes);
}
