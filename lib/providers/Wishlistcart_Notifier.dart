import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/wishlistModel.dart';


class WishlistNotifier extends StateNotifier<List<WishlistItem>> {
  WishlistNotifier() : super([]);

  void addItem(WishlistItem item) {
    state = [...state, item];
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clearWishlist() {
    state = [];
  }

}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<WishlistItem>>((ref) {
  return WishlistNotifier();
});
