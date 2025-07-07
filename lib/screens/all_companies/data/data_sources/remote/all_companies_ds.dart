
import '../../models/AllCompaniesModel.dart';

abstract class AllCompaniesDs {
  Future<AllCompaniesModel> getCompanies({
    required int PageSize,
    required int PageIndex,
    String? sort,
    int? rate
  });
}
