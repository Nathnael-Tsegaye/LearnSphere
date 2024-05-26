import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/providers/Wishlistcart_Notifier.dart';

class WishlistPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              ref.read(wishlistProvider.notifier).clearWishlist();
            },
          ),
        ],
      ),
      body: wishlist.isEmpty
          ? const Center(child: Text
          ('Your wishlist is empty',
           style: TextStyle(
             fontWeight: FontWeight.bold,
           ) ))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final item = wishlist[index];
                return Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10), 
                     border: Border.all(color: Colors.grey), 
                   ),
                   child: ListTile(
                     title: Text(item.title),
                     subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                     trailing: IconButton(
                       icon:const Icon(Icons.remove_circle_outline),
                       onPressed: () {
                         ref.read(wishlistProvider.notifier).removeItem(item.id as String);
                       },
                     ),
                   ),
                 );
              },
            ),
    );
  }
}
