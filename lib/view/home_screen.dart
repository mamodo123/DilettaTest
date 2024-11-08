import 'package:dilleta_test/view/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/favorite_list_cubit.dart';
import '../helpers/consts/config.dart';
import '../model/character.dart';
import 'buffer_list.dart';

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
      appBar: AppBar(title: const Text(appName)),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: BlocBuilder<FavoriteListCubit, Map<String, Character?>>(
                builder: (context, favorites) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.favorite),
                  Text(
                    favorites.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  )
                ],
              );
            }),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
