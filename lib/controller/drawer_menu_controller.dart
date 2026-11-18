import 'package:get/get.dart';

import 'package:pas_api_muhammadalfarrold_21/pages/feat_page.dart';
import 'package:pas_api_muhammadalfarrold_21/menu/profile.dart';
import 'package:pas_api_muhammadalfarrold_21/pages/listmakanan_page.dart';


class MainMenuController extends GetxController {
  var currentIndex = 0.obs;

  final pages = [
    ListMakananPage(),
    FeatPage(),
    ProfilePage(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.back();
  }
}