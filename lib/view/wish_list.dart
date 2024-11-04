import 'package:dilleta_test/view/widgets/character_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/favorite_list_cubit.dart';
import '../model/character.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteListCubit, Map<String, Character?>>(
        builder: (context, favorites) {
      final favoritesList = favorites.values.toList().reversed.toList();
      return favoritesList.isEmpty
          ? const Center(
              child: Text('Your Wishlist is empty!'),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final character = favoritesList[index];
                return character == null
                    ? Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: 80,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : CharacterListItem(character, true);
              },
              itemCount: favoritesList.length,
            );
    });
  }
}
