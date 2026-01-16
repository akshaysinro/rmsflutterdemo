import 'package:flutter/material.dart';
import 'package:flutter_rms/features/pos/completed/completed_page.dart';
import 'package:flutter_rms/features/pos/dining/dining_page.dart';
import 'package:flutter_rms/features/pos/running/running_page.dart';

class PosHomePage extends StatefulWidget {
  const PosHomePage({super.key});

  @override
  State<PosHomePage> createState() => _PosHomePageState();
}

class _PosHomePageState extends State<PosHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Define colors for each tab
  final List<Color> _bgColors = [
    Colors.orange,     // Dining
    Colors.green,      // Running
    Colors.blueGrey,   // Completed
  ];

  int _currentIndex = 0;

  final List<String> _tabNames = [
    "Dining Tables",
    "Running Orders",
    "Completed Orders",
  ];

  @override
  void initState() {
    super.initState();
    // length: 3 matches your 3 pages
    _tabController = TabController(length: 3, vsync: this);
    
    // Add listener to detect tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging || _tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tabNames[_currentIndex], 
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)
        ),
        // Dynamic background color based on current index
        backgroundColor: _bgColors[_currentIndex],
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(icon: Icon(Icons.restaurant), text: "Dining"),
            Tab(icon: Icon(Icons.directions_run), text: "Running"),
            Tab(icon: Icon(Icons.check_circle), text: "Completed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DiningPage(),
          RunningPage(),
          CompletedPage(),
        ],
      ),
    );
  }
}