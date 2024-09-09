import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '../models/api_error_model.dart';

dynamic handleHttpResponse<T>(http.Response response, T Function(Map<String, dynamic>) fromJson, {bool isList = false}) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return parseJsonToModel<T>(response.body, fromJson, isList:isList);
    case 204:
      return ApiError(message: 'Content Deleted: The resource was successfully deleted');
    case 400:
      throw ApiError(message: 'Bad Request: Invalid syntax.');
    case 401:
      throw ApiError(message: 'Unauthorized: Invalid credentials.');
    case 403:
      throw ApiError(message: 'Forbidden: No permission.');
    case 404:
      throw ApiError(message: 'Not Found: Resource not found.');
    case 405:
      throw ApiError(message: 'Method Not Allowed.');
    case 408:
      throw ApiError(message: 'Request Timeout.');
    case 429:
      throw ApiError(message: 'Too Many Requests.');
    case 500:
      throw ApiError(message: 'Internal Server Error.');
    case 502:
      throw ApiError(message: 'Bad Gateway.');
    case 503:
      throw ApiError(message: 'Service Unavailable.');
    case 504:
      throw ApiError(message: 'Gateway Timeout.');
    default:
      throw ApiError(message: 'Unexpected Error: HTTP ${response.statusCode}');
  }
}

T parseJsonToModel<T>(String responseBody, T Function(Map<String, dynamic>) fromJson, {bool isList = false}) {
  final dynamic jsonData = jsonDecode(responseBody);

  if (isList) {
    // Handle JSON data as a list
    final List<dynamic> jsonList = jsonData as List<dynamic>;
    return jsonList.map((jsonItem) => fromJson(jsonItem as Map<String, dynamic>)).toList() as T;
  } else {
    // Handle JSON data as a single object
    final Map<String, dynamic> jsonMap = jsonData as Map<String, dynamic>;
    return fromJson(jsonMap);
  }
}

class FetchData<T> {
  final T data;
  final bool isLoading;
  final ApiError? error;
  final VoidCallback refetch;

  FetchData({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}

class FetchListData<T> {
  final List<T> data;
  final bool isLoading;
  final ApiError? error;
  final VoidCallback refetch;

  FetchListData({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
