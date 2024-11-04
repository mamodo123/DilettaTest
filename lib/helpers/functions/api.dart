import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/api.dart';
import '../consts/api.dart' as api_urls;

Future<ApiResponse> fetchCharactersFromPage({int page = 1}) async {
  final url = Uri.https(
    api_urls.url,
    api_urls.endpoint,
    {'page': page.toString()},
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ApiResponse.fromJson(json: json, url: url.toString());
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception('Failed to fetch characters: $e');
  }
}
