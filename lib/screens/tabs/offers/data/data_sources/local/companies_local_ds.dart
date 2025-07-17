import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';

abstract class CompaniesLocalDs {
  Future<void> cacheCompanies(AllCompaniesModel companies);
  Future<AllCompaniesModel?> getCachedCompanies();
}