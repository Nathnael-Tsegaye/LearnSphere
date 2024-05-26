import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/services/network_request.dart';

class whatsnewPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final whatsnewAsyncValue = ref.watch(whatsnewdprovider);

    return Scaffold(
      appBar: AppBar(
        title:const Text('Whats New ?', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: whatsnewAsyncValue.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load data')),
        data: (courses) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, 
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75, 
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final pair = courses[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        pair.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pair.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
