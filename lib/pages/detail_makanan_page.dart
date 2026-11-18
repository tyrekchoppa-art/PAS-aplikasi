import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_api_muhammadalfarrold_21/models/makanan_model.dart';
import 'package:pas_api_muhammadalfarrold_21/controller/home_page.controller.dart';
import 'package:pas_api_muhammadalfarrold_21/pages/checkout_page.dart';

class DetailMakananPage extends StatelessWidget {
  const DetailMakananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipe makanan = Get.arguments as Recipe;
    final HomePageController controller = Get.find<HomePageController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(makanan.name),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                makanan.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              makanan.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "Rp ${makanan.caloriesPerServing * 100}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${makanan.cuisine} • ${makanan.caloriesPerServing} Kkal • ⭐ ${makanan.rating}",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const Divider(height: 30),
            const Text(
              "Bahan-bahan:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...makanan.ingredients.map((item) => Text("• $item")),
            const Divider(height: 30),
            const Text(
              "Instruksi Memasak:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...makanan.instructions.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text("${e.key + 1}. ${e.value}"),
                  ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            controller.tambahKeKeranjang(makanan);
                  Get.to(() => CheckoutPage());
          },
          icon: const Icon(Icons.add_shopping_cart),
          label: Text(
            "Tambah ke Keranjang (Rp ${makanan.caloriesPerServing * 100})",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            

          ),
        ),
      ),
    );
  }
}