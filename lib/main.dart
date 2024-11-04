import 'package:dilleta_test/controller/favorite_list_cubit.dart';
import 'package:dilleta_test/view/buffer_list.dart';
import 'package:dilleta_test/view/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/buffer_list_cubit.dart';

void main() {
  runApp(MaterialApp(
    home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BufferListCubit()),
        BlocProvider(create: (_) => FavoriteListCubit()),
      ],
      child: const HomeScreen(),
    ),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BufferList(),
    const WishList(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty\'s Wishlist')),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
