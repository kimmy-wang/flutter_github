import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/presentation/views/home_view.dart';
import '../modules/home_detail/bindings/detail_binding.dart';
import '../modules/home_detail/presentation/views/details_view.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: Routes.DETAILS,
          page: () => DetailsView(),
          binding: DetailBinding(),
        ),
      ],
    ),
  ];
}
