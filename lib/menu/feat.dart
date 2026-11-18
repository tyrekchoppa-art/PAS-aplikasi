import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/feat_page.controller.dart';

class FeatPage extends StatelessWidget {
  FeatPage({super.key});

  final FeatController pageController = Get.put(FeatController());

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
              itemCount: pageController.listFeat.length,
              itemBuilder: (context, index) {
                final makanan = pageController.listFeat[index];

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
                            makanan.idTeam,
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
                                  makanan.strTeam,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  makanan.strStadium,
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