import 'dart:convert';

import 'package:dilleta_test/model/character.dart';
import 'package:http/http.dart' as http;

import '../../model/api.dart';
import '../consts/api.dart' as api_urls;

Future<ApiListResponse> fetchCharactersFromPage({int page = 1}) async {
  final url = Uri.https(
    api_urls.url,
    api_urls.endpoint,
    {'page': page.toString()},
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ApiListResponse.fromJson(json: json, url: url.toString());
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception('Failed to fetch characters: $e');
  }
}

Future<Map<String, Character>> fetchCharactersFromList(List<String> ids) async {
  final url = Uri.https(
    api_urls.url,
    '${api_urls.endpoint}/[${ids.join(',')}]',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> jsonList =
          (jsonDecode(response.body) as List<dynamic>).cast();
      return Map.fromEntries(jsonList.map((json) {
        final character = Character.fromJson(json);
        return MapEntry(character.id.toString(), character);
      }));
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception('Failed to fetch characters: $e');
  }
}

Future<Character> fetchCharactersFromId(String id) async {
  final url = Uri.https(
    api_urls.url,
    '${api_urls.endpoint}/$id',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Character.fromJson(json);
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception('Failed to fetch characters: $e');
  }
}
