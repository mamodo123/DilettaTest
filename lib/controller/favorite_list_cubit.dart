import 'dart:collection';

import 'package:dilleta_test/model/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/consts/shared_pref.dart';
import '../helpers/functions/api.dart';
import '../helpers/functions/shared_pref.dart';

class FavoriteListCubit extends Cubit<Map<String, Character?>> {
  FavoriteListCubit() : super({});

  Future<void> loadData(
      {List<Character>? items, void Function(Exception)? onError}) async {
    final itemsMap = items == null
        ? {}
        : Map.fromEntries(items.map((e) => MapEntry(e.id.toString(), e)));
    final favorites = await getHashSet(favoritesKey);
    if (favorites != null) {
      emit(Map.fromEntries(favorites.map((e) => MapEntry(e, itemsMap[e]))));
    }

    final nullToFetch =
        state.entries.where((e) => e.value == null).map((e) => e.key).toList();
    if (nullToFetch.isNotEmpty) {
      try {
        final favoritesCharacters = await fetchCharactersFromList(nullToFetch);

        emit(Map.fromEntries(state.entries.map(
            (e) => MapEntry(e.key, e.value ?? favoritesCharacters[e.key]))));
      } on Exception catch (e) {
        onError?.call(e);
      }
    }
  }

  Future<void> addFavorite(String id,
      {Character? character, void Function(Exception)? onError}) async {
    emit({...state, id: character});
    await saveHashSet(HashSet.from(state.keys), favoritesKey);

    if (character == null) {
      try {
        final character = await fetchCharactersFromId(id);
        emit(Map.from(state..[id] = character));
      } on Exception catch (e) {
        onError?.call(e);
        emit(Map.from(state..remove(id)));
      }
    }
  }

  Future<void> removeFavorite(String id) async {
    emit(Map.from(state..remove(id)));
    await saveHashSet(HashSet.from(state.keys), favoritesKey);
  }
}
