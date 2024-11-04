import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveHashSet(HashSet<String> hashSet, String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = hashSet.toList();
  await prefs.setStringList(key, list);
}

Future<HashSet<String>?> loadHashSet(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? list = prefs.getStringList(key);
  if (list == null) {
    return null;
  }
  return HashSet<String>.from(list);
}

Future<void> addItem(String item, String key) async {
  HashSet<String> hashSet = await loadHashSet(key) ?? HashSet();
  hashSet.add(item);
  await saveHashSet(hashSet, key);
}
