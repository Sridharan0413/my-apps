import 'package:flutter/material.dart';
import 'package:my_apps/home/account_page.dart';
import 'package:my_apps/home/favourite.dart';
import 'package:my_apps/home/favourite_manager.dart';
import 'package:provider/provider.dart';
import 'package:my_apps/home/explore_page.dart';
import 'package:my_apps/home/cart_page.dart';
import 'package:my_apps/screens/onboarding.dart';
import 'package:my_apps/screens/onboarding_2.dart';
import 'package:my_apps/screens/loging_page.dart';
import 'package:my_apps/screens/grocery_login_screen.dart';
import 'package:my_apps/screens/grocery_login_screen_2.dart';
import 'package:my_apps/screens/location.dart';
import 'package:my_apps/screens/sign_in.dart';
import 'package:my_apps/home/home_page.dart';
import 'package:my_apps/home/cart_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(create: (_) => FavoriteManager()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Grocery App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Onboarding(),
        '/home': (context) => const Home(),
        '/login': (context) => const GroceryLoginScreen(),
        '/login1': (context) => const GroceryLoginScreen2(),
        '/location': (context) => const Location(),
        '/logingpage': (context) => const LogingPage(),
        '/signin': (context) => const SignIn(),
        '/homepage': (context) => HomePage(),
        '/explore': (context) => const ExplorePage(allProducts: []),
        '/mycart': (context) => const MyCartPage(),
        '/favorites':(context) => const FavoritePage(),
        '/account':(context) => const AccountPage()
      },
    );
  }
}





