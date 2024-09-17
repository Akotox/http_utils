import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '../models/api_error_model.dart';

dynamic handleHttpResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return response.body;
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


/// Custom exception class to handle various Firebase authentication-related errors.
class FirebaseAuthErrorHandler {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  FirebaseAuthErrorHandler(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again.';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'user-token-revoked':
        return 'The user\'s token has been revoked. Please sign in again.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid recipient email.';
      case 'auth-domain-config-required':
        return 'The authDomain configuration is required for the action code verification link.';
      case 'missing-app-credential':
        return 'The app credential is missing. Please provide valid app credentials.';
      case 'invalid-app-credential':
        return 'The app credential is invalid. Please provide a valid app credential.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'app-deleted':
        return 'This instance of FirebaseApp has been deleted.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled.';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the provided API key.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      default:
        return 'An unexpected authentication error occurred. Please try again.';
    }
  }
}
