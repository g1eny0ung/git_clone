/// Supported protocols
enum Protocol { https, git }

/// Supported platforms
enum Platform { github, gitlab, bitbucket }

extension on Platform {
  String toHost() {
    final literal = toString().split('.').last;

    switch (this) {
      case Platform.github:
      case Platform.gitlab:
        return '$literal.com';
      case Platform.bitbucket:
        return '$literal.org';
      default:
        throw UnsupportedError('Platform $literal is not supported');
    }
  }
}

extension PlatformParsing on Platform {
  String parseUri(String ownerAndRepo, [Protocol protocol = Protocol.https]) {
    final host = toHost();

    switch (protocol) {
      case Protocol.https:
        return 'https://$host/$ownerAndRepo.git';
      case Protocol.git:
        return 'git@$host:$ownerAndRepo.git';
      default:
        throw ArgumentError('Unsupported protocol: $protocol');
    }
  }
}
