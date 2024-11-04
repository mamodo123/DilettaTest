import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/functions/api.dart';
import '../model/api.dart';
import '../model/character_state.dart';

class BufferListCubit extends Cubit<CharacterState> {
  BufferListCubit() : super(CharacterState.initial());

  final Map<int, ApiResponse> pages = {};
  int? nextPage = 1;

  Future<void> loadPage() async {
    if (nextPage != null) {
      emit(state.copyWith(status: CharacterStatus.loading));

      try {
        final response = await fetchCharactersFromPage(page: nextPage!);
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
        }
      } catch (error) {
        emit(state.copyWith(
          characters: state.characters,
          status: CharacterStatus.error,
          message: 'Error in load list items',
        ));
      }
    }
  }
}
