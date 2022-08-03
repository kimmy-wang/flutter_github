import 'package:flutter/material.dart';
import 'package:flutter_github/pages/home/presentation/widgets/repository_item.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.add),
        //   onPressed: () {
        //     Get.snackbar('title', 'message');
        //   },
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: () {
              Get.updateLocale(Locale('zh', 'CN'));
            },
          )
        ],
        title: Text('app_name'.tr),
        elevation: 0,
        centerTitle: true,
      ),
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
                          .toNamed('/home/details?index=$index');
                    },
                    child: RepositoryItem(
                      index: index,
                      repository: trending,
                      last: index == controller.state!.length - 1,
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
