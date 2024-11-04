import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveHashSet(HashSet<String> hashSet, String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = hashSet.toList();
  await prefs.setStringList(key, list);
}

Future<HashSet<String>?> getHashSet(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? list = prefs.getStringList(key);
  if (list == null) {
    return null;
  }
  return HashSet<String>.from(list);
}

Future<bool> addItem(String item, String key) async {
  HashSet<String> hashSet = await getHashSet(key) ?? HashSet();
  bool added = hashSet.add(item);
  await saveHashSet(hashSet, key);
  return added;
}

Future<bool> removeItem(String item, String key) async {
  HashSet<String>? hashSet = await getHashSet(key);
  if (hashSet != null) {
    final removed = hashSet.remove(item);
    if (removed) {
      await saveHashSet(hashSet, key);
      return removed;
    }
  }
  return false;
}
