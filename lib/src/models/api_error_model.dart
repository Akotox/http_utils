class ApiError {
  final String message;

  ApiError({required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
    message: json["message"],
  );
}
