import 'package:flutter/material.dart';
import 'fav_tab_widgets/favorites.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FavoritesPage(),
      ),
    );
  }
}
