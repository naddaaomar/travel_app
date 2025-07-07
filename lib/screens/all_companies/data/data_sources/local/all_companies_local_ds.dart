import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';

abstract class AllCompaniesLocalDs {
  Future<void> cacheCompanies(AllCompaniesModel companies);
  Future<AllCompaniesModel?> getCachedCompanies();
}
