import 'package:dilleta_test/controller/favorite_list_cubit.dart';
import 'package:dilleta_test/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  final bool favorite;

  const CharacterListItem(this.character, this.favorite, {super.key});

  LinearGradient _getCardGradient(String status) {
    switch (status) {
      case 'Alive':
        return const LinearGradient(
          colors: [Colors.green, Colors.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Dead':
        return const LinearGradient(
          colors: [Colors.red, Colors.redAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [Colors.grey, Colors.blueGrey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  Color _getBorderColor(String status) {
    switch (status) {
      case 'Alive':
        return Colors.greenAccent;
      case 'Dead':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient: _getCardGradient(character.status),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getBorderColor(character.status),
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    character.image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Origin: ${character.origin.name}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.heart_broken,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Status: ${character.status}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  final cubit = context.read<FavoriteListCubit>();
                  if (favorite) {
                    cubit.removeFavorite(character.id.toString());
                  } else {
                    cubit.addFavorite(character.id.toString(),
                        character: character, onError: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Could not add to Wishlist  '),
                          duration: Duration(seconds: 2), // Duração da Snackbar
                        ),
                      );
                    });
                  }
                },
                icon: Icon(
                  favorite ? Icons.favorite : Icons.favorite_outline_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
