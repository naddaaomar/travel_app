part of 'all_com_cubit.dart';

sealed class AllComState {}

final class AllComInitial extends AllComState {}
final class Loading extends AllComState {}
final class Success extends AllComState {
  final AllCompaniesModel allCompanies;

  Success(this.allCompanies);
}
final class Error extends AllComState {}
