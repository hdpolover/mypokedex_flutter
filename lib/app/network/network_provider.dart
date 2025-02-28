import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mypokedex/app/core/values/app_strings.dart';

class NetworkProvider extends GetxService {
  static NetworkProvider get to => Get.find();
  final http.Client _client = http.Client();

  /// Returns a response from a GET request to the specified endpoint
  ///
  /// [endpoint] - The API endpoint without the base URL
  /// [headers] - Optional HTTP headers for the request
  Future<dynamic> getRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('${AppStrings.baseUrl}$endpoint');

    try {
      final response = await _client.get(
        url,
        headers: headers ?? {'Content-Type': 'application/json'},
      );

      // Check if the request was successful
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse JSON if response is successful
        return json.decode(response.body);
      } else {
        // Handle error responses
        throw HttpException(
          message: 'Request failed with status: ${response.statusCode}',
          uri: url,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      // Re-throw the error for handling in the controller
      rethrow;
    }
  }
}

/// Custom exception for HTTP errors
class HttpException implements Exception {
  final String message;
  final Uri uri;
  final int statusCode;

  HttpException({
    required this.message,
    required this.uri,
    required this.statusCode,
  });

  @override
  String toString() {
    return 'HttpException: $message (Status: $statusCode, URL: $uri)';
  }
}
