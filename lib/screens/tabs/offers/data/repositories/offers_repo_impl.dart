import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/helpers/internet_checker/internet_checker.dart';
import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';
import 'package:p/screens/tabs/offers/data/data_sources/local/companies_local_ds.dart';
import 'package:p/screens/tabs/offers/data/data_sources/local/offers_local_ds.dart';
import '../../domain/repositories/offers_repo.dart';
import '../data_sources/remote/offers_ds.dart';

@Injectable(as: OffersRepo)
class OffersRepoImpl implements OffersRepo {
  final OffersDs offersDs;
  final OffersLocalDs offersLocalDs;
  final CompaniesLocalDs companiesLocalDs;

  final NetworkInfo networkInfo;

  OffersRepoImpl(
    this.offersDs,
    this.offersLocalDs,
    this.networkInfo,
      this.companiesLocalDs
  );
  @override
  Future<Either<ErrorFailures, AllCompaniesModel>> getCompanies({
    required int PageIndex,
    required int PageSize,
    String? sort,
    int? rate,
  }) async {
    final isFiltered = (sort != null && sort != 'default') || rate != null;

    try {
      if (await networkInfo.isConnected) {
        final data = await offersDs.getCompanies(
          PageSize: PageSize,
          PageIndex: PageIndex,
          rate: rate,
          sort: sort,
        );

        // Debug logging
        print('Repository received data type: ${data.runtimeType}');

        // Ensure we're working with the model
        final companies = data is AllCompaniesModel
            ? data
            : AllCompaniesModel.fromJson(data as Map<String, dynamic>);

        if (!isFiltered) {
          await companiesLocalDs.cacheCompanies(companies);
        }
        return Right(companies);
      } else {
        if (!isFiltered) {
          final cached = await companiesLocalDs.getCachedCompanies();
          return cached != null
              ? Right(cached)
              : Left(ErrorLocalFailure("No internet and no cached companies"));
        } else {
          return Left(ErrorLocalFailure("لا يمكنك استخدام الفلاتر دون اتصال بالإنترنت"));
        }
      }
    } catch (e) {
      print('Repository error: $e');
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, DiscountItemsModel>> getDiscounts({
    required int PageIndex,
    required int PageSize,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await offersDs.getDiscount(
            PageSize: PageSize, PageIndex: PageIndex);
        print("before CAche//////////////////////////////////");

        await offersLocalDs.cacheDiscounts(data);
        print("after CAche /////////////////////////////////////////");

        return Right(data);
      } else {
        final cached = await offersLocalDs.getCachedDiscounts();
        if (cached != null) {
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure("No internet and no cached discounts"));
        }
      }
    } catch (e) {
      print("discontsssssssssssssssssssssss");
      print(e.toString());
      print(e.toString());
      print(e.toString());
      print(e.toString());
      print(e.toString());
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
