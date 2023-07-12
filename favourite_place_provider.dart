import 'dart:io';

import 'package:favourite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getdb() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'create TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
  }, version: 1);
  return db;
}

class FavouritePlaceNotifier extends StateNotifier<List<Place>> {
  FavouritePlaceNotifier() : super([]);
  Future<void> loadplaces() async {
    final db = await _getdb();
    final data = await db.query("user_places");
    final places = data
        .map((row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String)))
        .toList();
    state = places;
  }

  void addfavouriteplace(String title, File image) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    Place newplace = Place(title: title, image: copiedImage);
    final db = await _getdb();
    db.insert("user_places",
        {'id': newplace.id, 'title': newplace.title, 'image': newplace.image});
    state = [...state, Place(title: title, image: copiedImage)];
  }
}

final favouritePlaceProvider =
    StateNotifierProvider<FavouritePlaceNotifier, List<Place>>((ref) {
  return FavouritePlaceNotifier();
});
