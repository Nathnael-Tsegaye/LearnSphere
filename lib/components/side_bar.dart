import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/providers/profileprovider.dart';


class SideBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${profile?.firstname} ${profile?.lastname}'),
            accountEmail: Text('${profile?.email}'),
            currentAccountPicture: CircleAvatar(
  child: ClipOval(
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/profile'); 
      },
      child: profile?.imageUrl != null
          ? Image.network(
              profile!.imageUrl, 
              fit: BoxFit.cover,
              width: 90,
              height: 90,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); 
              },
            )
          : const Icon(Icons.error), 
    ),
  ),
),
             decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 52, 41, 82),
                  Color.fromARGB(255, 52, 50, 54),
                ],
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('./lib/images/wallpaperflare.com_wallpaper.jpg')),
            ),
          ),
           ListTile(
           leading: Icon(Icons.home),
            title: Text('Home'),
              onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
          ),
           ListTile(
           leading: Icon(Icons.list),
            title: Text('Wish list'),
             onTap: () {
                  Navigator.pushNamed(context, '/wishlist');
                },
          ),
          ListTile(
           leading: Icon(Icons.lock_clock),
            title: Text('Progress'),
           onTap: () {
                  Navigator.pushNamed(context, '/popular');
                },
          ),
          ListTile(
             leading: Icon(Icons.person),
            title: Text('Profile'),
          onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
          ),
          ListTile(
             leading: Icon(Icons.settings),
            title: Text('Settings'),
             onTap: () {
                  Navigator.pushNamed(context, '/Settings');
                },
          ),
          ListTile(
           leading:const Icon(Icons.notification_add),
            title: Text('Notifications'),
           onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
          ),
          const SizedBox(height: 70.0),

          Divider(),
          ListTile(
             leading: Icon(Icons.logout),
            title: Text('logout'),
            onTap: () {
                  Navigator.pushNamed(context, '/');
                },
          ),
        ],
      ),
    );
  }
}
