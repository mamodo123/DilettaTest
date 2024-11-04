import 'package:dilleta_test/view/characters_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/characters_cubit.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (_) => CharactersCubit(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty characters'),
      ),
      body: CharactersList(),
    );
  }
}
