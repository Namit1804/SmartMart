import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_mart/views/screens/account_screen.dart';
import 'package:smart_mart/views/screens/cart_screen.dart';
import 'package:smart_mart/views/screens/category_screen.dart';
import 'package:smart_mart/views/screens/favorite_screen.dart';
import 'package:smart_mart/views/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/store-1.png',
                width: 20,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/explore.svg'),
            label: 'CATEGORIES',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/cart.svg'),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/favorite.svg'),
            label: 'FAVORITE',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg'),
            label: 'ACCOUNT',
          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}
