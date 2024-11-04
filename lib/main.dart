import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/characters_cubit.dart';
import 'model/character_state.dart';

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
  var _loading = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> loadPage() async {
    _loading = true;
    try {
      await context.read<CharactersCubit>().loadPage();
    } finally {
      _loading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPage();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_loading) {
        loadPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharactersCubit, CharacterState>(
        builder: (context, state) {
          if (state.status == CharacterStatus.initial) {
            return const Center(
              child: Text('Carregando itens da lista...'),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.characters.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.characters.length,
                      itemBuilder: (context, index) {
                        final character = state.characters[index];
                        return ListTile(title: Text(character.name));
                      },
                    ),
                  ),
                if (state.status == CharacterStatus.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state.message != null)
                  Center(
                    child: Text(state.message!),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
