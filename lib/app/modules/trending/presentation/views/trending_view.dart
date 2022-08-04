import 'package:flutter/material.dart';
import 'package:flutter_github/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/trending_controller.dart';
import '../widgets/repository_item.dart';

class TrendingView extends GetView<TrendingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: controller.obx(
          (state) {
            return ListView.builder(
              itemCount: controller.state!.length,
              itemBuilder: (context, index) {
                final trending = controller.state![index];
                return GestureDetector(
                  onTap: () {
                    Get.rootDelegate
                        .toNamed(Routes.TRENDING_DETAILS(trending.name));
                  },
                  child: RepositoryItem(
                    index: index + 1,
                    repository: trending,
                    last: index == controller.state!.length - 1,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
