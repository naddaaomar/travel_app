import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../../../all_travels/presentation/pages/all_travels.dart';
import '../../data/service/favorites_service.dart';
import '../manager/favorites_cubit.dart';
import '../manager/favorites_state.dart';
import '../widgets/favorite_list.dart';
import '../widgets/no_favorites.dart';
import 'package:http/http.dart' as http;


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(
        favoritesService: FavoritesService(client: http.Client()),
        secureStorage: const FlutterSecureStorage(),
      )..setContext(context),
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading || state is FavoritesInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return NoFavorites(
                onAddFavorite: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AllTravels()),
                  );
                },
              );
            }
            return FavoriteList(favorites: state.favorites);
          } else if (state is FavoritesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}