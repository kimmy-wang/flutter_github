import '../entity/trending_model.dart';

// ignore: one_member_abstracts
abstract class IHomeRepository {
  Future<List<TrendingModel>> getTrending();
}
