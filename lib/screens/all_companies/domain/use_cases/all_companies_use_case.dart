import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import '../../data/models/AllCompaniesModel.dart';
import '../repositories/all_companies_repo.dart';

@injectable
class AllCompaniesUseCase {
  AllCompaniesRepo allCompaniesRepo;

  AllCompaniesUseCase(this.allCompaniesRepo);

  Future<Either<ErrorFailures, AllCompaniesModel>> call({
    required int PageIndex,
    required int PageSize,
    String? sort,
    int? rate
  }) =>
      allCompaniesRepo.getCompanies(PageIndex: PageIndex, PageSize: PageSize,sort: sort,rate: rate);
}