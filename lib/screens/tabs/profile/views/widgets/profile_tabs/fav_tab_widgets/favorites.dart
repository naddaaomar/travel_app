import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'no_fav.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: ValueListenableBuilder<List<String>>(
        valueListenable: FavoriteManager().favoritesNotifier,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return  NoFavorites(onAddFavorite: () {  },);
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(favorites[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    FavoriteManager().toggleFavorite(favorites[index], context);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FavoriteManager {
  static final FavoriteManager _instance = FavoriteManager._internal();
  final ValueNotifier<List<String>> favoritesNotifier = ValueNotifier([]);

  factory FavoriteManager() => _instance;

  FavoriteManager._internal() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoritesNotifier.value = prefs.getStringList('favorites') ?? [];
  }

  Future<void> toggleFavorite(String tripId, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentFavorites = List<String>.from(favoritesNotifier.value);

      if (currentFavorites.contains(tripId)) {
        currentFavorites.remove(tripId);
      } else {
        currentFavorites.add(tripId);
      }

      await prefs.setStringList('favorites', currentFavorites);
      favoritesNotifier.value = currentFavorites;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update favorites')),
      );
    }
  }
}