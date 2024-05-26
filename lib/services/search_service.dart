import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/models/searchModel.dart'; 

class SearchService {
  static Future<List<SearchResult>> search(String query) async {
    final response = await http.get(Uri.parse('https://example.com/api/search?q=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => SearchResult.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
