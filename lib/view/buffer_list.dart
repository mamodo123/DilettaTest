import 'package:dilleta_test/controller/favorite_list_cubit.dart';
import 'package:dilleta_test/model/character.dart';
import 'package:dilleta_test/view/widgets/character_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/buffer_list_cubit.dart';
import '../model/character_state.dart';

class BufferList extends StatefulWidget {
  const BufferList({super.key});

  @override
  State<BufferList> createState() => _BufferListState();
}

class _BufferListState extends State<BufferList> {
  var _loading = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> loadPage() async {
    _loading = true;
    try {
      await context.read<BufferListCubit>().loadPage();
    } finally {
      _loading = false;
    }
  }

  Future<void> loadInitialData(BuildContext context) async {
    await loadPage();
    if (context.mounted) {
      final alreadyLoadedItems = context.read<BufferListCubit>().state;
      await context.read<FavoriteListCubit>().loadData(
          items: alreadyLoadedItems.characters,
          onError: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not load Wishlist'),
                duration: Duration(seconds: 2), // Duração da Snackbar
              ),
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadInitialData(context);
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
    return BlocBuilder<FavoriteListCubit, Map<String, Character?>>(
        builder: (context, favorites) {
      return BlocBuilder<BufferListCubit, CharacterState>(
        builder: (context, state) {
          if (state.status == CharacterStatus.initial) {
            return const Center(
              child: Text('Loading items...'),
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
                        final favorite =
                            favorites.containsKey(character.id.toString());
                        return CharacterListItem(character, favorite);
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
      );
    });
  }
}
