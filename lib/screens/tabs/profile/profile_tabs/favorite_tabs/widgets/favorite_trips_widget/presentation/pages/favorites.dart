import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:p/screens/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/tabs/profile/profile_tabs/favorite_trips_widget/presentation/widgets/no_favorites.dart';
import '../manager/favorites_cubit.dart';
import '../manager/favorites_state.dart';
import '../widgets/favorite_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<AuthCubit>()),
        BlocProvider(
          create: (context) => FavoritesCubit(
            client: http.Client(),
          ),
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {
            if (state is FavoritesError) {}
          },
          builder: (context, state) {
            if (state is FavoritesLoading || state is FavoritesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesLoaded) {
              return FavoriteList(
                favorites: state.favorites,
                onToggleFavorite: (trip) {
                  context.read<FavoritesCubit>().toggleFavorite(trip);
                },
              );
            }
            return NoFavorites(onAddFavorite: () { },);
          },
        ),
      ),
    );
  }
}