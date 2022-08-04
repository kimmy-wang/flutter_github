
import '../domain/adapters/repository_adapter.dart';
import '../domain/entity/trending_model.dart';
import 'trending_api_provider.dart';

class TrendingRepository implements ITrendingRepository {
  TrendingRepository({required this.provider});
  final ITrendingProvider provider;

  @override
  Future<List<TrendingModel>> getTrending() async {
    final cases = await provider.getTrending("/");
    if (cases.status.hasError) {
      return Future.error(cases.statusText!);
    } else {
      return cases.body!;
    }
  }
}
