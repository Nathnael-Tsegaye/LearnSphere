import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/WhatsNewMo.dart';
import 'package:test/models/wishlistModel.dart';
import 'package:test/providers/Wishlistcart_Notifier.dart';

class WhatsNewPage extends StatefulWidget {
  final WhatsnewModel whatsnewModel;

  const WhatsNewPage({Key? key, required this.whatsnewModel}) : super(key: key);

  @override
  _WhatsNewPageState createState() => _WhatsNewPageState();
}

class _WhatsNewPageState extends State<WhatsNewPage> {
  late Widget currentBottomPage = Lessonspage(whatsnewModel: widget.whatsnewModel);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final whatsnewModel = widget.whatsnewModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200.0,
                child: Image.network(
                  whatsnewModel.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20.0),
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
                          'Name: ${whatsnewModel.title}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Price: ${whatsnewModel.price}',
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
                          id: whatsnewModel.id,
                          title: whatsnewModel.title,
                          imageUrl: whatsnewModel.imageUrl,
                          price: whatsnewModel.price,
                        );
                        ref.read(wishlistProvider.notifier).addItem(wishlistItem);
                      },
                      child: const Text('Add to wishlist'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
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
              currentBottomPage = Lessonspage(whatsnewModel: widget.whatsnewModel);
              break;
            case 1:
              currentBottomPage = SecondHalfPage(whatsnewModel: widget.whatsnewModel);
              break;
            case 2:
              currentBottomPage = ThirdHalfPage();
              break;
            default:
              currentBottomPage = Lessonspage(whatsnewModel: widget.whatsnewModel);
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


class SecondHalfPage extends StatelessWidget {
  final WhatsnewModel whatsnewModel;

  const SecondHalfPage({Key? key, required this.whatsnewModel}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('About Mentor'),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
whatsnewModel.title,
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
whatsnewModel.description,
style: const TextStyle(fontSize: 18.0),
),
),
],
),
),
);
}
}






class Lessonspage extends StatelessWidget {
  final WhatsnewModel whatsnewModel;

  const Lessonspage({Key? key, required this.whatsnewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 126, 132, 171),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: whatsnewModel.chapters.length,
        itemBuilder: (context, index) {
          final chapter = whatsnewModel.chapters[index];
          return ListTile(
            title: Text(chapter.title),
            subtitle: Text(chapter.content),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondHalfPage(whatsnewModel: whatsnewModel),
                ),
              );
            },
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
          'This is where the reviews will be',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}