import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/helpers/internet_checker/internet_checker.dart';
import 'package:p/screens/tabs/home/data/data_sources/local/home_local_ds.dart';
import 'package:p/screens/tabs/home/data/data_sources/local/recommendation_local_ds.dart';
import 'package:p/screens/tabs/home/data/data_sources/remote/home_ds.dart';
import 'package:p/screens/tabs/home/data/models/EventRecommendation.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';
import 'package:p/screens/tabs/home/domain/repositories/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDs homeDs;
  final HomeLocalDs localDs;
  final RecommendationLocalDs recommendationLocalDs;
  final NetworkInfo networkInfo;

  HomeRepoImpl(this.homeDs, this.localDs, this.networkInfo,this.recommendationLocalDs);

  @override
  Future<Either<ErrorFailures, NewestModel>> getNewest({
    required int PageIndex,
    required int PageSize,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await homeDs.getNewest(
          PageSize: PageSize,
          PageIndex: PageIndex,
        );
        await localDs.cacheNewest(data);
        print("✅ Newest data cached");
        return Right(data);
      } else {
        final cached = await localDs.getCachedNewest();
        if (cached != null) {
          print("📦 Using cached newest data");
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure('No internet and no cached data.'));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, List<EventsModel>>> getEvents() async {
    try {
      if (await networkInfo.isConnected) {
        final data = await homeDs.getEvents();
        await localDs.cacheEvents(data);
        print("✅ Events data cached");
        return Right(data);
      } else {
        final cached = await localDs.getCachedEvents();
        if (cached != null) {
          print("📦 Using cached events data");
          return Right(cached);
        } else {
          return Left(
              ErrorLocalFailure('No internet and no cached events data.'));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, List<EventRecommendation>>> getEventRecommend({
    required int numRecommendations,
    required int numHighestInteractions,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await homeDs.getEventRecommend(
          numHighestInteractions: numHighestInteractions,
          numRecommendations: numRecommendations,
        );
        await recommendationLocalDs.cacheEventRecommendations(data);
        print("✅ Event recommendations cached");
        return Right(data);
      } else {
        final cached = await recommendationLocalDs.getCachedEventRecommendations();
        if (cached != null) {
          print("📦 Using cached event recommendations");
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure('No internet and no cached event recommendations.'));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
  @override
  Future<Either<ErrorFailures, List<TravelRecommendation>>> getTravelRecommend({
    required int numRecommendations,
    required int numHighestInteractions,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await homeDs.getTravelRecommend(
          numHighestInteractions: numHighestInteractions,
          numRecommendations: numRecommendations,
        );
        await recommendationLocalDs.cacheTravelRecommendations(data);
        print("✅ Travel recommendations cached");
        return Right(data);
      } else {
        final cached = await recommendationLocalDs.getCachedTravelRecommendations();
        if (cached != null) {
          print("📦 Using cached travel recommendations");
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure('No internet and no cached travel recommendations.'));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

}
