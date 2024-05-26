import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/grid_view.dart';
import 'package:test/models/wishlistModel.dart';
import 'package:test/pages/home_page.dart';
import 'package:test/pages/wishlist.dart';
import 'package:test/providers/Wishlistcart_Notifier.dart';
import 'package:test/services/network_request.dart';

class Popularpage extends StatefulWidget {
  @override
  _PopularpageState createState() => _PopularpageState();
}

class _PopularpageState extends State<Popularpage> {
  late Widget currentBottomPage = Lessonspage();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final AsyncValue<List<PopularModel>> popularModelList =
                  ref.watch(populardprovider);
              return popularModelList.when(
                data: (popularModels) {
                  final popularModel = popularModels[0];
                  return Column(
                    children: [
                        SizedBox(
                        height: 200.0,
                        child:  
                        Image.network(
                          popularModel.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                         SizedBox(height: 20.0),
                         Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                      Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                     ' Name: ${popularModel.title}',
                                           style:const TextStyle(
                                             color: Colors.black,
                                             fontSize: 20.0,
                                             fontWeight: FontWeight.bold,
                                           ),
                                         ),
                                         Text(
                                       ' Price: ${popularModel.price}',
                                           style: const TextStyle(
                                             color: Color.fromARGB(136, 11, 11, 11),
                                             fontSize: 16.0,
                                             fontWeight: FontWeight.bold,

                                           ),
                                         ),
                                       ],
                                     ),
                             ElevatedButton(
                               onPressed: ()   {
                             final popularModel = popularModels[0]; // using the first item in the list...assumption
                             final wishlistItem = WishlistItem(
                               id: popularModel.id,
                               title: popularModel.title,
                               imageUrl: popularModel.imageUrl, 
                               price: popularModel.price,
                             );
                             ref.read(wishlistProvider.notifier).addItem(wishlistItem);
                           },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Color.fromARGB(255, 96, 110, 152),
                                 foregroundColor: Colors.white,
                                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0),
                                 ),
                                 elevation: 5.0,
                               ),
                               child: const Text(
                                 'Add to wishlist',
                                 style: TextStyle(
                                   fontSize: 16.0,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                           ],
                         ),
                        
                         )
                       ],
                    
                  );
                },
                loading: () => CircularProgressIndicator(),
                 error: (error, stackTrace) => Column( // TBD
                    children: [
                        SizedBox(
                        height: 200.0,
                        child:  
                        Image.asset(
                          './lib/images.pain.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                         SizedBox(height: 20.0),
                         Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                     ' Name: life',
                                           style: TextStyle(
                                             color: Colors.black,
                                             fontSize: 20.0,
                                             fontWeight: FontWeight.bold,
                                           ),
                                         ),
                                         Text(
                                       ' Price: 250 birr',
                                           style: TextStyle(
                                             color: Color.fromARGB(136, 11, 11, 11),
                                             fontSize: 16.0,
                                             fontWeight: FontWeight.bold,

                                           ),
                                         ),
                                       ],
                                     ),
                             ElevatedButton(
                               onPressed: () {
                                 Navigator.pop(context);
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistPage()));
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Color.fromARGB(255, 96, 110, 152),
                                 foregroundColor: Colors.white,
                                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0),
                                 ),
                                 elevation: 5.0,
                               ),
                               child: const Text(
                                 'Add to wishlist',
                                 style: TextStyle(
                                   fontSize: 16.0,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                           ],
                         ),
                        
                         )
                       ],
              
                 // Center(
                //   child: SizedBox(
                //     height: 200.0,
                //     child: Text('Error: $error'),
                //   ),
                // ),
                 )
                 );
            },
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTitle('Lessons', 0),
              buildTitle('About mentor', 1),
              buildTitle('Reviews', 2),
            ],
          ),
          Expanded(
            child: currentBottomPage,
          ),
        ],
      ),
    );
  }

  Widget buildTitle(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          switch (selectedIndex) {
            case 0:
              currentBottomPage = Lessonspage();
              break;
            case 1:
              currentBottomPage = SecondHalfPage();
              break;
            case 2:
              currentBottomPage = ThirdHalfPage();
              break;
            default:
              currentBottomPage = Lessonspage();
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Container(
              height: 2.0,
              width: 30.0,
              color: index == selectedIndex ? Color.fromARGB(255, 71, 70, 70) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class Lessonspage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<PopularModel>> popularModelList = ref.watch(populardprovider);

    return popularModelList.when(
      data: (popularModels) {
        final List<Chapter> chapters = popularModels[0].chapters;

        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 126, 132, 171),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapter = chapters[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondHalfPage(),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(chapter.title),
                  subtitle: Text(chapter.content),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Container( // TBD
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 232, 232, 236),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondHalfPage(),
                  ),
                );
              },
              child: const Card(
                color: Color.fromARGB(255, 90, 111, 129),
                child: ListTile(
                  title: Text('Chapter one'),
                  subtitle: Text('Lesson 1'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class SecondHalfPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularAsyncValue = ref.watch(populardprovider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Half Page'),
      ),
      body: popularAsyncValue.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load data')),
        data: (popularItems) {
          if (popularItems.isEmpty) {
            return Center(child: Text('No items found'));
          }

          final item = popularItems[0]; // Assuming you want the first item

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.description,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class ThirdHalfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'This is the third half page.',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
