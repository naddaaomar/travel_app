import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/rating_use_case.dart';
import '../manager/rating_cubit.dart';
import 'rating_view.dart';

class CompanyRatingWidget extends StatelessWidget {
  final int companyId;
  final String userId;
  final String userName;

  const CompanyRatingWidget({
    required this.companyId,
    required this.userId,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyRatingCubit(
        context.read<CompanyRatingUseCase>(),
      )..loadCompanyRatings(companyId),
      child: CompanyRatingView(
        companyId: companyId,
        userId: userId,
        userName: userName,
      ),
    );
  }
}
