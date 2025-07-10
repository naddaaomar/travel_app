import 'package:p/screens/tabs/home/data/models/NewestModel.dart';

abstract class NewestHomeLocalDs {
  Future<void> cacheNewest(NewestModel newestModel);
  Future<NewestModel?> getCachedNewest();
}