import '../domain/adapters/repository_adapter.dart';
import '../domain/entity/trending_model.dart';
import 'home_api_provider.dart';

class HomeRepository implements IHomeRepository {
  HomeRepository({required this.provider});
  final IHomeProvider provider;

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
