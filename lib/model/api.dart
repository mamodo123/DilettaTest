import 'character.dart';

class ApiListResponse {
  final String url;
  final Info info;
  final List<Character>? results;

  ApiListResponse({required this.info, required this.results, required this.url});

  ApiListResponse.fromJson({required Map<String, dynamic> json, required this.url})
      : info = Info.fromJson(json: json['info'], page: Info.extractPage(url)),
        results = json['results'] == null
            ? null
            : List<Character>.from(json['results']
                .map((character) => Character.fromJson(character)));
}

class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final int page;

  Info(
      {required this.count,
      required this.pages,
      this.next,
      this.prev,
      required this.page});

  Info.fromJson({required Map<String, dynamic> json, required this.page})
      : count = json['count'],
        pages = json['pages'],
        next = json['next'],
        prev = json['prev'];

  static int extractPage(String url) {
    final uri = Uri.parse(url);
    final page = uri.queryParameters['page'];
    return int.parse(page ?? '1');
  }
}
