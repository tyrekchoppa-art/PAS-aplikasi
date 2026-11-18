import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_page.controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController pageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List makanan"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Obx(
          () => SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: pageController.listData.length,
              itemBuilder: (context, index) {
                final makanan = pageController.listData[index];

                return InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            makanan.image,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  makanan.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rp ${makanan.caloriesPerServing * 100}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}