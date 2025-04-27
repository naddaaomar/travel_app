part of 'company_details_cubit.dart';

@immutable
sealed class CompanyDetailsState {}

final class CompanyDetailsInitial extends CompanyDetailsState {}

final class CompanyDetailsLoading extends CompanyDetailsState {}

final class CompanyDetailsSuccess extends CompanyDetailsState {
  CompanyDetailsModel companyDetailsModel;

  CompanyDetailsSuccess(this.companyDetailsModel);
}

final class CompanyDetailsError extends CompanyDetailsState {}
