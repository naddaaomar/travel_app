import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';

abstract class TravelFilterRepo {
  Future<Either<ErrorFailures, List<CategoryModel>>> getCategories();
}