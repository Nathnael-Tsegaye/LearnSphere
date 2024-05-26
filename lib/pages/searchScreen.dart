import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test/models/Course.dart';
import 'package:test/providers/searchprovider.dart';
import 'package:test/components/search_bar.dart' as MySearchBar;
import 'package:test/pwip/popular.dart';
import 'package:test/services/network_request.dart'; 


class SearchScreen extends ConsumerStatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final searchResults = ref.watch(searchProvider);
     final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 25.0, 5.0),
        child: Column(
          children: [
            MySearchBar.SearchBar(searchController: searchController),
            const SizedBox(height: 10),
            const SizedBox(height: 5),
            const Text(
              'Search results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Coursemodel>>(
                future: Future.delayed(const Duration(seconds: 2), () {
                  return ref.watch(courseprovider.future) ?? Future.value([]);
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Popularpage(), 
                              ),
                            );
                          },
                          child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 203, 205, 208),
                            highlightColor: const Color.fromARGB(255, 238, 235, 235),
                            child: Container(
                              width: 150,
                              height: 200.0,
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final courseItem = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Popularpage(), 
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 200.0,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Image.network(courseItem.imageUrl),
                                Text(courseItem.title),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
