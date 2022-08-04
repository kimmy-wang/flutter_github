import 'package:get/get.dart';

import '../presentation/controllers/trending_detail_controller.dart';


class TrendingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrendingDetailController(
      Get.parameters['repoName'] ?? '',
    ));
  }
}
