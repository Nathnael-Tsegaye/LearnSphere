import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/providers/searchprovider.dart'; 


class SearchBar extends ConsumerWidget {
  final TextEditingController searchController;

  SearchBar({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 25.0, 5.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              width: 100,
              padding: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  // prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            height: 45,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 52, 41, 82),
                  Color(0xff281537),
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: () => ref.read(searchProvider.notifier).search(searchController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: const Center(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
