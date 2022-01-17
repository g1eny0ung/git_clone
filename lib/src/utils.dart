/// Supported schemes
enum Scheme { https, git }

extension on Scheme {
  String toLiteral() {
    return toString().split('.').last;
  }
}

/// Supported platforms
enum Platform { github, gitlab, bitbucket }

extension PlatformParsing on Platform {
  String parseUri(String ownerAndRepo, Scheme? scheme) {
    return 'uri';
  }
}
