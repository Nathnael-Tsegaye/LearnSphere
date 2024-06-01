

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test/components/Notificationbell.dart';
import 'package:test/models/WhatsNewMo.dart';
import 'package:test/models/CatagoryMo.dart';
import 'package:test/models/grid_view.dart';
import 'package:test/pwIp/catagory.dart';
import 'package:test/pwIp/coursepage.dart';
// import 'package:test/pwIp/popularPage.dart';
// import 'package:test/pwIp/whatsnew.dart'; 
import '../components/side_bar.dart';
import '../services/network_request.dart';
// ignore: library_prefixes
import 'package:test/components/search_bar.dart' as MySearchBar;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();


    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        actions: const [
         Padding(
          padding: EdgeInsets.only(right: 14.0),
          child: 
          NotificationBell(),
          )
        ],
      ),
      body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 25.0, 5.0),
        child: Column(
          children: [
            MySearchBar.SearchBar(searchController: searchController),
            const SizedBox(height: 10),
         
  
    
      const SizedBox(height: 5),
      const Text(
        'Popular',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    

    Container(
            height: 200,
  child: FutureBuilder<List<PopularModel>>(
future: Future.delayed(const Duration(seconds: 2), () {
    return ref.watch(populardprovider.future) ?? Future.value([]);
  }),    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
           
             Shimmer.fromColors(
               baseColor:const Color.fromARGB(255, 203, 205, 208),
            highlightColor:const Color.fromARGB(255, 238, 235, 235),
              child: Container(
                width: 150,
                height: 200.0,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                color: Colors.white,
              ),
            )
        ;
             return null;
          },
        );
      }else if (snapshot.hasError) {
 //  return Text('Error: ${snapshot.error}');

  return ListView.builder(
     
    scrollDirection: Axis.horizontal,
    itemCount: 5,
    itemBuilder: (context, index) {
    

            String title = faker.person.name();

      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => coursepage(),)
          );
        },
        child: Container(
              width: 170,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                
                  Image.asset('./lib/images/faker replace.jpg'),
                  const SizedBox(height: 2),
                  

                ],
              ),
            )
            );
          },
        );
       } else {
               return ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemCount: snapshot.data!.length,
                 itemBuilder: (context, index) {
                   final pair = snapshot.data![index];
                   return InkWell(
                        onTap: () {
         Navigator.pushNamed(
           context,
           '/popularpage',
           arguments: pair, 
         );
       },
            child: Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pair.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Image.network(pair.imageUrl),
                  const SizedBox(height: 2),
                  

                ],
              ),
            )
            );
          },
        );
      }
    },
  ),
),
             const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Whats New ?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
             const SizedBox(height: 5,),
           Container(
            height: 200,
             child: FutureBuilder<List<WhatsnewModel>>(
            future: Future.delayed(const Duration(seconds: 2), () {
    return ref.watch(whatsnewdprovider.future) ?? Future.value([]);        
    }),              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, 
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor:const Color.fromARGB(255, 203, 205, 208),
            highlightColor:const Color.fromARGB(255, 238, 235, 235),
                        child: Container(
                          width: 150,
                          height: 200.0, 
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                      color: Colors.white,     
                                      ),
                        )
                      );
                      
                    },
                  );
                } 
                 
                 else if (snapshot.hasError) {
                  //  return Text('Error: ${snapshot.error}');
                 return ListView.builder(
                         scrollDirection: Axis.horizontal,
                         itemCount: 5,
                         itemBuilder: (context, index) {
                            String title = faker.person.name();
                                return InkWell(
                  onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => coursepage(),)
                   );
                 },
                   child: Container(
                       width: 170,
                 margin: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       title,
                       style: const TextStyle(
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     const SizedBox(height: 2),
                     Image.asset('./lib/images/faker replace.jpg'),
                     const SizedBox(height: 2),
                  

                ],
              ),
            )
            );
          },
          
        );
        

                } else {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      final pair = snapshot.data![index];
      return InkWell(
       onTap: () {
  Navigator.pushNamed(
    context,
    '/whatsnewpage',
    arguments: pair, 
  );
},
        child: Container(
          width: 150,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pair.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Image.network(pair.imageUrl),
              const SizedBox(height: 4),
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
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Catagories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
             const SizedBox(height: 5,),
           Container(
            height: 200,
             child: FutureBuilder<List<CategoryModel>>(
       future: Future.delayed(const Duration(seconds: 2), () {
    return ref.watch(catagorydprovider.future) ?? Future.value([]);
  }),              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, 
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                           baseColor:const Color.fromARGB(255, 203, 205, 208),
            highlightColor:const Color.fromARGB(255, 238, 235, 235),
                        child: Container(
                          width: 150,
                          height: 200.0, 
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      )
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  //  return Text('Error: ${snapshot.error}');
                      return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      String title= faker.person.name();
                     return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryPage())
          );
        },
        child: Container(
              width: 170,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Image.asset('./lib/images/faker replace.jpg'),
                  const SizedBox(height: 2),
                  

                ],
              ),
            )
            );
          },
        );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final pair = snapshot.data![index];
                      return InkWell(
               onTap: () {
                  Navigator.pushNamed(context, '/catagory');
                },
                     child: Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pair.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Image.network(pair.imageUrl),
                            const SizedBox(height: 4),

                          ],
                        ),
                      )
                      );
                    },
                  );
                }
              },
            ),
           ),
          ]
        )
      )
    )
    );
  }
}
