import 'package:dilleta_test/model/character.dart';
import 'package:flutter/material.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  const CharacterListItem(this.character, {super.key});

  Color? _getCardColor(String status) {
    switch (status) {
      case 'Alive':
        return Colors.green;
      case 'Dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getCardColor(character.status),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              character.image,
              height: 80,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    character.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  'Origin: ${character.origin.name}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Status: ${character.status}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
