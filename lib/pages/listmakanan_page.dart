import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_api_muhammadalfarrold_21/controller/home_page.controller.dart';
import 'detail_makanan_page.dart';

class ListMakananPage extends StatelessWidget {
  ListMakananPage({super.key});

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Menu"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 8,
                top: 8,
                child: Obx(() {
                  if (controller.keranjang.isEmpty) return const SizedBox();
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${controller.keranjang.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.listData.length,
          itemBuilder: (context, index) {
            final makanan = controller.listData[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    makanan.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  makanan.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Rp ${makanan.caloriesPerServing * 100} • ⭐ ${makanan.rating}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.to(() => const DetailMakananPage(), arguments: makanan);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
