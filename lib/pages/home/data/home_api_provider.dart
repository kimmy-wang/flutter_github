import 'package:get/get.dart';
import '../domain/entity/trending_model.dart';

// ignore: one_member_abstracts
abstract class IHomeProvider {
  Future<Response<List<TrendingModel>>> getTrending(String path);
}

class HomeProvider extends GetConnect implements IHomeProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder =
        (val) => List<TrendingModel>.from((val as Iterable).map(
              (x) => TrendingModel.fromJson(x as Map<String, dynamic>),
        ));
    httpClient.baseUrl = 'https://api.gitterapp.com';
  }

  @override
  Future<Response<List<TrendingModel>>> getTrending(String path) => get(path);
}
