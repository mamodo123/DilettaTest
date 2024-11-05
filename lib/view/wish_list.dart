import 'package:dilleta_test/view/widgets/character_list_item.dart';
import 'package:dilleta_test/view/widgets/delayed_submit_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/favorite_list_cubit.dart';
import '../model/character.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  String? _filter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteListCubit, Map<String, Character?>>(
        builder: (context, favorites) {
      var favoritesList = favorites.values.toList().reversed.toList();
      final filteredList = _filter == null
          ? favoritesList
          : favoritesList
              .where((e) =>
                  e?.name.toLowerCase().contains(_filter!.toLowerCase()) ??
                  false)
              .toList();
      return Column(
        children: [
          if (filteredList.isNotEmpty || _filter != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: DelayedSubmitTextField(
                onSubmit: (text) {
                  setState(() {
                    _filter = text;
                  });
                },
              ),
            ),
          Expanded(
            child: filteredList.isEmpty
                ? const Center(
                    child: Text('Your Wishlist is empty!'),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final character = filteredList[index];
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
                      itemCount: filteredList.length,
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
