abstract class BaseApiPaths {
  String get baseUrl;
}

class ApisModel {
  const ApisModel({
    this.create = const ApiModel(path: ''),
    this.delete = const ApiModel(path: ''),
    this.get = const ApiModel(path: ''),
    this.update = const ApiModel(path: ''),
  });

  final ApiModel create;
  final ApiModel delete;
  final ApiModel get;
  final ApiModel update;
}

class ApiModel {
  const ApiModel({
    required this.path,
    this.version,
  });

  /// API path.
  final String path;

  /// API version.
  final String? version;
}
