import 'dart:async';
import 'dart:io';

class ServiceResponse<T> {
  T? data;
  bool error;
  String message;

  ServiceResponse({
    this.data,
    required this.error,
    required this.message,
  });
}

ServiceResponse<T> serveError<T>({String? error}) {
  return ServiceResponse(
    error: true,
    message: error ?? "Something went wrong",
  );
}

ServiceResponse<T> serveData<T>({T? data, String? message}) {
  return ServiceResponse(
    error: false,
    message: message ?? "Success",
    data: data,
  );
}

Future<ServiceResponse<T>> serveFuture<T>({
  required Future<T> Function(Fail fail) function,
  String Function(Object e)? handleError,
  String Function(T response)? handleData,
}) async {
  try {
    final T response = await function(_fail);
    String? message;
    if (handleData != null) {
      message = handleData(response);
    }
    return serveData<T>(data: response, message: message);
  } on ServeException catch (e) {
    return serveError(error: e.message);
  } on SocketException {
    return serveError(error: "No internet connection");
  } on TimeoutException {
    return serveError(error: "Connnection Timeout");
  } on TypeError catch (e) {
    return serveError(error: "$e");
  } on NoSuchMethodError catch (e) {
    return serveError(error: "$e");
  } catch (e) {
    return serveError(error: "$e");
  }
}

typedef Fail = Function(String message);

Never _fail(String message) => throw ServeException(message);

const defaultError = 'Service Temporarily Unavailable!';
const timeoutE = 'Connection Timeout';

class ServeException implements Exception {
  String message;

  ServeException(this.message);
}
