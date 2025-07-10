import 'package:p/screens/tabs/home/data/models/NewestModel.dart';

abstract class HomeDs {
  Future<NewestModel> getNewest({
    required int PageSize,
    required int PageIndex,
  });
}