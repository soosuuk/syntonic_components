class HttpResponseMessageModel {
  HttpResponseMessageModel(this.code, this.title, this.content);
  
  int? code;
  String? title;
  String? content;

  factory HttpResponseMessageModel.fromJson(Map<String, dynamic> json) {
    return HttpResponseMessageModel(
      json['code'] as int?,
      json['title'] as String?,
      json['info'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'info': content,
    };
  }
}