import 'package:flutter/material.dart';
import 'package:flutter_rms/common/home.dart';
import 'package:flutter_rms/features/kitchen/KitchenPage.dart';
import 'package:flutter_rms/features/outlet/domain/Hotel.dart';
import 'package:flutter_rms/features/outlet/domain/Outlet.dart';
import 'package:flutter_rms/features/outlet/domain/Recipe.dart';
import 'package:flutter_rms/features/pos/pos_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F&B Enterprise Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      // PATH 1: The Initial Route (Home)
      home: const HomePage(), 
      
      // PATH 2: Defined Routes (For later use)
      routes: {
        '/hotel-setup': (context) => const HotelSetupPage(),
        '/outlet-setup': (context) => const OutletSetupPage(),
        '/recepie-setup': (context) => const RecipeSetupPage(),
        '/pos': (context) => const PosHomePage(),
        '/kitchen': (context) => const KitchenPage(),
      },
    );
  }
}