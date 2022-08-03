import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(
              "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.snackbar('title', 'message');
            },
          ),
          title: Text('covid'.tr),
          backgroundColor: Colors.white10,
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
                    return ListTile(
                      onTap: () {
                        Get.rootDelegate
                            .toNamed('/home/details?index=$index');
                      },
                      // trailing: CircleAvatar(
                      //   backgroundImage: NetworkImage(
                      //       "https://flagpedia.net/data/flags/normal/${country.countryCode.toLowerCase()}.png"),
                      // ),
                      title: Text(trending.name),
                      subtitle: Text(
                        // ignore: lines_longer_than_80_chars
                          '${trending.description}'),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
