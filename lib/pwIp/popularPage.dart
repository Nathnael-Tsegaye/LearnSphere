import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/grid_view.dart';
import 'package:test/models/wishlistModel.dart';
// import 'package:test/pages/wishlist.dart';
import 'package:test/providers/Wishlistcart_Notifier.dart';
// import 'package:test/services/network_request.dart';

class Popularpage extends StatefulWidget {
  final PopularModel popularModel;

const Popularpage({Key? key, required this.popularModel}) : super(key: key);
  @override
  _PopularpageState createState() => _PopularpageState();
}

class _PopularpageState extends State<Popularpage> {
  late Widget currentBottomPage = Lessonspage(popularModel: widget.popularModel,);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final popularModel = widget.popularModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('detailed', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200.0,
                child: Image.network(
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
                          'Name: ${popularModel.title}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Price: ${popularModel.price}',
                          style: const TextStyle(
                            color: Color.fromARGB(136, 11, 11, 11),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final wishlistItem = WishlistItem(
                          id: popularModel.id,
                          title: popularModel.title,
                          imageUrl: popularModel.imageUrl,
                          price: popularModel.price,
                        );
                        ref.read(wishlistProvider.notifier).addItem(wishlistItem);
                      },
                      child: const Text('Add to wishlist'),
                    ),
                  ],
                ),
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
          );
        },
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
              currentBottomPage = Lessonspage(popularModel: widget.popularModel);
              break;
            case 1:
              currentBottomPage = SecondHalfPage(popularModel: widget.popularModel);
              break;
            case 2:
              currentBottomPage = ThirdHalfPage();
              break;
            default:
              currentBottomPage = Lessonspage(popularModel: widget.popularModel);
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
              color: index == selectedIndex ? const Color.fromARGB(255, 71, 70, 70) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class Lessonspage extends StatelessWidget {
  final PopularModel popularModel;

  const Lessonspage({Key? key, required this.popularModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 126, 132, 171),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: popularModel.chapters.length,
        itemBuilder: (context, index) {
          final chapter = popularModel.chapters[index];
          return ListTile(
            title: Text(chapter.title),
            subtitle: Text(chapter.content),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondHalfPage(popularModel: popularModel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SecondHalfPage extends StatelessWidget {
  final PopularModel popularModel;

  const SecondHalfPage({Key? key, required this.popularModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Half Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              popularModel.title,
              style: const TextStyle(
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
                popularModel.description,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
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
          'This is where the reviews will be',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
