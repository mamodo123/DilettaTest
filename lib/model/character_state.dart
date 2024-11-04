import 'character.dart';

enum CharacterStatus { initial, loading, loaded, error }

class CharacterState {
  final CharacterStatus status;
  final List<Character> characters;
  final String? message;

  CharacterState({
    required this.status,
    required this.characters,
    this.message,
  });

  factory CharacterState.initial() {
    return CharacterState(
      status: CharacterStatus.initial,
      characters: [],
    );
  }

  CharacterState copyWith({
    CharacterStatus? status,
    List<Character>? characters,
    String? message,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      message: message ?? this.message,
    );
  }
}
