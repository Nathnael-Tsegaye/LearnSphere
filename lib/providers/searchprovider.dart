import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/searchModel.dart';
import 'package:test/services/search_service.dart'; 

class SearchNotifier extends StateNotifier<List<SearchResult>> {
  SearchNotifier() : super([]);

  Future<void> search(String query) async {
    try {
      final results = await SearchService.search(query);
      state = results;
    } catch (error) {
     throw Exception('No such query found');

    }
  }

  void clearResults() {
    state = [];
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, List<SearchResult>>((ref) {
  return SearchNotifier();
});
