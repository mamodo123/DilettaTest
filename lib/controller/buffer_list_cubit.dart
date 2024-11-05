import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/exceptions.dart';
import '../helpers/functions/api.dart';
import '../model/api.dart';
import '../model/character_state.dart';

class BufferListCubit extends Cubit<CharacterState> {
  BufferListCubit() : super(CharacterState.initial());

  final Map<int, ApiListResponse> pages = {};
  int? nextPage = 1;
  Map<String, dynamic>? cache;

  Future<CharacterState?> loadPage(
      {String? filter, bool reload = false}) async {
    if (reload && cache == null && filter != null) {
      cache = {
        'state': state,
        'pages': Map<int, ApiListResponse>.from(pages),
        'nextPage': nextPage,
      };
    }

    if (reload && cache != null && filter == null) {
      pages.addAll(cache!['pages']);
      nextPage = cache!['nextPage'];
      emit(cache!['state']);
      cache = null;
    } else {
      if (reload) {
        pages.clear();
        nextPage = 1;
        emit(CharacterState.initial());
      }
      if (nextPage != null) {
        emit(state.copyWith(status: CharacterStatus.loading));

        try {
          final response =
              await fetchCharactersFromPage(page: nextPage!, filter: filter);
          if (response.results != null &&
              (nextPage == null || response.info.page == nextPage!)) {
            pages[response.info.page] = response;
            if (response.info.next == null) {
              nextPage = null;
            } else {
              nextPage = Info.extractPage(response.info.next!);
            }
            emit(state.copyWith(
              status: CharacterStatus.loaded,
              characters: [...state.characters, ...response.results!],
            ));
            return state;
          }
        } on NoItemsFoundException catch (error) {
          emit(state.copyWith(
            characters: state.characters,
            status: CharacterStatus.error,
            message: error.message,
          ));
        } on Exception catch (_) {
          emit(state.copyWith(
            characters: state.characters,
            status: CharacterStatus.error,
            message: 'Error in load list items',
          ));
        }
      }
    }

    return null;
  }
}
