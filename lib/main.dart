import 'package:flutter/material.dart';
import 'package:pas_api_muhammadalfarrold_21/routes.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "My Learning App",
      initialRoute: Routes.loginclone,
      getPages: Routes.myPages,
    );
  }
}
