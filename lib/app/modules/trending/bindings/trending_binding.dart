import 'package:get/get.dart';

import '../data/trending_api_provider.dart';
import '../data/trending_repository.dart';
import '../domain/adapters/repository_adapter.dart';
import '../presentation/controllers/trending_controller.dart';

class TrendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ITrendingProvider>(() => TrendingProvider());
    Get.lazyPut<ITrendingRepository>(() => TrendingRepository(provider: Get.find()));
    Get.lazyPut(() => TrendingController(trendingRepository: Get.find()));
  }
}
