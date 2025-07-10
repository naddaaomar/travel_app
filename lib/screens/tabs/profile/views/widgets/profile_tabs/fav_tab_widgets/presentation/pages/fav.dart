import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../auth/core/cubit/auth_cubit.dart';
import '../../api_favtab.dart';
import '../../favorites.dart';
import '../../service.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    super.initState();
    _favoritesCubit = FavoritesCubit(
      ApiService(authCubit: context.read<AuthCubit>()),
    )..loadFavorites();
  }

  @override
  void dispose() {
    _favoritesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _favoritesCubit,
      child: Scaffold(
        body: const FavoriteList(),
      ),
    );
  }
}