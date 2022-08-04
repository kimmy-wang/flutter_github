import 'package:get/get.dart';

import '../presentation/controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController(
      Get.parameters['repoName'] ?? '',
    ));
  }
}
