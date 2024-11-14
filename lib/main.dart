import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/pages/home.dart';
import 'presentation/pages/categories/categories.dart';
import 'presentation/pages/profile.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.black, displayColor: Colors.black),
        ),
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF0D1117),
        primaryColor: Color(0xFF58A6FF),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.dark, // Explicitly set brightness to dark
          backgroundColor: Color(0xFF0D1117),
          cardColor: Color(0xFF161B22),
        ).copyWith(
          secondary: Color(0xFF58A6FF),
        ),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0D1117),
          selectedItemColor: Color(0xFF58A6FF),
          unselectedItemColor: Colors.grey,
        ),
      ),
      themeMode: ThemeMode.dark, // Force dark theme for testing
      home: ExpenseTrackerHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExpenseTrackerHomePage extends StatefulWidget {
  @override
  _ExpenseTrackerHomePageState createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
