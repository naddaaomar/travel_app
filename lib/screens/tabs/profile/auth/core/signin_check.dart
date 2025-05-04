import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignInController {
  static const String _isSignedInKey = 'isSignedIn';

  static Future<void> handleAddToFavorites(BuildContext context,
      {VoidCallback? onSignedIn}) async {
    final prefs = await SharedPreferences.getInstance();
    final isSignedIn = prefs.getBool(_isSignedInKey) ??
        false;

    if (!isSignedIn) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ),
      );

      final prefsAfterSignIn = await SharedPreferences.getInstance();
      final isSignedInAfterSignIn =
          prefsAfterSignIn.getBool(_isSignedInKey) ?? false;

      if (isSignedInAfterSignIn) {
        if (onSignedIn != null) {
          onSignedIn();
        } else {
          _addToFavorites(context);
        }
      } else {
        _showSignInFailedMessage(context);
      }
    } else {
      if (onSignedIn != null) {
        onSignedIn();
      } else {
        _addToFavorites(context); //  Or show a message
      }
    }
  }

  static void _addToFavorites(BuildContext context) {
    print('Adding to favorites...');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added to favorites!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static void _showSignInFailedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign in failed.  Please try again.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool _isFirstTime = true;
  final List<String> _favoriteItems =
  [];

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstTime = prefs.getBool('notFirstTime') ?? true;
    });
    if (_isFirstTime) {
      prefs.setBool('notFirstTime', false);
    }
  }

  void _addItemToFavorites() {
    setState(() {
      _favoriteItems.add('New Favorite Item ${_favoriteItems.length + 1}');
    });
    _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favoriteItems', _favoriteItems); //  Use a dedicated key.
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedItems = prefs.getStringList('favoriteItems');
    if (savedItems != null) {
      setState(() {
        _favoriteItems.addAll(savedItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isFirstTime
            ?  NoFavorites(onAddFavorite: () {},)
            : _buildFavoritesList(), //
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  Use the SignInController to handle the logic
          SignInController.handleAddToFavorites(context, onSignedIn: () {
            _addItemToFavorites(); //  This is called AFTER successful sign-in
          });
        },
        child: const Icon(Icons.add_to_queue),
      ),
    );
  }

  Widget _buildFavoritesList() {
    if (_favoriteItems.isEmpty) {
      return const Center(child: Text("No favorites yet."));
    }
    return ListView.builder(
      itemCount: _favoriteItems.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(_favoriteItems[index]),
          ),
        );
      },
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool(SignInController._isSignedInKey,
                true);
            Navigator.of(context).pop(); //  Go back to the previous page.
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}

class NoFavorites extends StatelessWidget{
  const NoFavorites({super.key, required Null Function() onAddFavorite});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("No Favorites"));
  }
}
