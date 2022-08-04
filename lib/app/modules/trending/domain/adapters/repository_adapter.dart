import '../entity/trending_model.dart';

// ignore: one_member_abstracts
abstract class ITrendingRepository {
  Future<List<TrendingModel>> getTrending();
}
