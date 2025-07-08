import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/auth/core/signin_check.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<bool> _isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSignedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: FutureBuilder<bool>(
        future: _isSignedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading sign-in status.'));
          }

          final bool isSignedIn = snapshot.data ?? false;
          if (isSignedIn) {
            return ValueListenableBuilder<List<String>>(
              valueListenable: FavoriteManager().favoritesNotifier,
              builder: (context, favorites, _) {
                if (favorites.isEmpty) {
                  return NoFavorites(onAddFavorite: () {});
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
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Please sign in to view your favorites.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ),
                      );
                      setState(() {});
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            );
          }
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
        const SnackBar(content: Text('Failed to update favorites.')),
      );
    }
  }
}