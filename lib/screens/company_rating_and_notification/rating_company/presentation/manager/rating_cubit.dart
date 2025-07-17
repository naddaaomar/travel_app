import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import '../../data/model/rating_model.dart';
import '../../domain/use_cases/rating_use_case.dart';

part 'rating_state.dart';

@injectable
class CompanyRatingCubit extends Cubit<CompanyRatingState> {
  final CompanyRatingUseCase companyRatingUseCase;

  CompanyRatingCubit(this.companyRatingUseCase) : super(CompanyRatingInitial());

  Future<void> submitRating(CompanyRatingModel rating) async {
    emit(CompanyRatingLoading());
    final result = await companyRatingUseCase.submitRating(rating);

    result.fold(
          (failure) => emit(CompanyRatingError(failure)),
          (_) => emit(CompanyRatingSubmitted()),
    );
  }

  Future<void> loadCompanyRatings(int companyId) async {
    emit(CompanyRatingLoading());
    final result = await companyRatingUseCase.getCompanyRatings(companyId);

    result.fold(
          (failure) => emit(CompanyRatingError(failure)),
          (ratings) => emit(CompanyRatingsLoaded(ratings)),
    );
  }
}