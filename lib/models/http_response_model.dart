import '../../models/http_response_message_model.dart';

class HttpResponseModel {
  HttpResponseModel({required this.body, required this.isSucceeded});
  
  dynamic body;
  bool isSucceeded = false;
}