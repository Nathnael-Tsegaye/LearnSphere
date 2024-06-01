import 'package:test/models/WhatsNewMo.dart';
import 'package:test/models/grid_view.dart';
import 'package:test/models/user.dart';
import 'package:test/pages/NotificationPage.dart';
import 'package:test/pages/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/pages/home_page.dart';
import 'package:test/pages/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/pages/profile.dart';
import 'package:test/pages/progress.dart';
import 'package:test/pages/searchScreen.dart';
import 'package:test/pages/settings.dart';
import 'package:test/pages/sign_up.dart';
import 'package:test/pages/wishlist.dart';
import 'package:test/pwIp/catagory.dart';
import 'package:test/pwIp/changepassword.dart';
import 'package:test/pwIp/popularPage.dart';
import 'package:test/pwIp/whatsnew.dart';
import 'package:test/pwIp/coursepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('user');

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Box<User> userBox = Hive.box<User>('user');
    final User? storedUsername = userBox.get('username');
    final User? storedPassword = userBox.get('password');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: storedUsername != null && storedPassword != null ? '/home' : '/',
      routes: {
        '/':(context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/signup':(context) => SignUpPage(),
        '/profile':(context) => ProfilePage(),
        '/wishlist':(context) => WishlistPage(),
        '/progress':(context) => progress(),
        '/OTP':(context) => OTPverF(),
        '/notification':(context) => NotificationScreen(),
        '/search':(context) => SearchScreen(),
        '/Settings':(context)=>settings(),
        '/catagory':(context)=>CategoryPage(),
        '/changepassw':(context)=>ChangePasswordPage(),
        '/course':(context)=>coursepage(),

      },
            onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/whatsnew':
                    if (settings.arguments is WhatsnewModel) {
                      final args = settings.arguments as WhatsnewModel;
                      return MaterialPageRoute(
                        builder: (context) {
                          return WhatsNewPage(whatsnewModel: args);
                        },
                      );
                    }
                    assert(false, 'Invalid arguments for /whatsnew');
                    return null;
                  
                  case '/popularpage':
                    if (settings.arguments is PopularModel) {
                      final args = settings.arguments as PopularModel;
                      return MaterialPageRoute(
                        builder: (context) {
                          return Popularpage(popularModel: args);
                        },
                      );
                    }
                    assert(false, 'Invalid arguments for /popularpage');
                    return null;


         // for catagory page
                   //  case '/catagorypage':
                   //   if (settings.arguments is PopularModel) {
                   //     final args = settings.arguments as PopularModel;
                   //     return MaterialPageRoute(
                   //       builder: (context) {
                   //         return Popularpage(popularModel: args);
                   //       },
                   //     );
                   //   }
                   //   assert(false, 'Invalid arguments for /popularpage');
                   //   return null;
         
                   default:
                     assert(false, 'Need to implement ${settings.name}');
                     return null;
                 }
               },
    );
  }
}