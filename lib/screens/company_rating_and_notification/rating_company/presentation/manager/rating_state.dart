part of 'rating_cubit.dart';


abstract class CompanyRatingState extends Equatable {
  const CompanyRatingState();

  @override
  List<Object> get props => [];
}

class CompanyRatingInitial extends CompanyRatingState {}

class CompanyRatingLoading extends CompanyRatingState {}

class CompanyRatingSubmitted extends CompanyRatingState {}

class CompanyRatingsLoaded extends CompanyRatingState {
  final List<CompanyRatingModel> ratings;

  const CompanyRatingsLoaded(this.ratings);

  @override
  List<Object> get props => [ratings];
}

class CompanyRatingError extends CompanyRatingState {
  final ErrorFailures failure;
  const CompanyRatingError(this.failure);

  @override
  List<Object> get props => [failure];
}