import 'package:http/http.dart';

extension StatusCodes on Response {
  bool get is200 => statusCode == 200;
  bool get is500 => statusCode == 500;
  bool get is400 => statusCode == 400;

  bool get is200or201 => statusCode == 200 || statusCode == 201;
  bool get is400or422 => statusCode == 400 || statusCode == 422;
}
