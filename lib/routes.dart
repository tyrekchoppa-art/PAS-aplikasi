import 'package:pas_api_muhammadalfarrold_21/pages/detail_makanan_page.dart';
import 'package:pas_api_muhammadalfarrold_21/pages/listmakanan_page.dart';
import 'package:pas_api_muhammadalfarrold_21/pages/login_page.dart';
import 'package:get/get.dart';

class Routes {
  static const String listmakanan = "/list_makanan";
  static const String detailmakanan = "/detail_makanan";
  static const String loginclone = "/login_clone"; 
  static final myPages = [
    GetPage(name: listmakanan, page: () => ListMakananPage()),
    GetPage(name: detailmakanan, page: () => DetailMakananPage()),
    GetPage(name: loginclone, page: () => LoginclonePage()),
  ];
}