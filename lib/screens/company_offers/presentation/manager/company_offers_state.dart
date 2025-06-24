part of 'company_offers_cubit.dart';

@immutable
sealed class CompanyOffersState {}

final class CompanyOffersInitial extends CompanyOffersState {}
final class CategoryFilter extends CompanyOffersState {}
final class PriceDescending extends CompanyOffersState {}
final class PriceAscending extends CompanyOffersState {}
final class PageNumber extends CompanyOffersState {}
final class CurrentPageScroll extends CompanyOffersState {}
final class LeftButton extends CompanyOffersState {}
final class NumberClicked extends CompanyOffersState {}
final class RightClicked extends CompanyOffersState {}
