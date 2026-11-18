import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:belajarflutter/models/listmakanan_model.dart';
import 'package:belajarflutter/Controller/listmakanan_controller.dart';
import 'package:belajarflutter/pages/checkout_page.dart';

class DetailMakananPage extends StatelessWidget {
  const DetailMakananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipe makanan = Get.arguments as Recipe;
    final ListMakananController controller = Get.find<ListMakananController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(makanan.name),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          // Ikon keranjang + angka jumlah barang di pojok kanan atas
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.to(() => CheckoutPage());
                },
              ),
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
ansjndjad

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:belajarflutter/Controller/listmakanan_controller.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  // Menyambungkan ke controller yang sudah aktif
  final ListMakananController controller = Get.find<ListMakananController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang & Checkout"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        // Jika keranjang masih kosong
        if (controller.keranjang.isEmpty) {
          return const Center(
            child: Text(
              "Keranjang masih kosong",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return Column(
          children: [
            // 1. Daftar Item Belanjaan
            Expanded(
              child: ListView.builder(
                itemCount: controller.keranjang.length,
                itemBuilder: (context, index) {
                  final item = controller.keranjang[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.image,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Rp ${item.caloriesPerServing * 100}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.hapusDariKeranjang(index),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 2. Kotak Rincian Harga, Diskon & Pajak
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal:"),
                      Text("Rp ${controller.subtotal.toStringAsFixed(0)}"),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Diskon (10% > 50rb):"),
                      Text(
                        "- Rp ${controller.diskon.toStringAsFixed(0)}",
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Pajak PPN (11%):"),
                      Text(
                        "+ Rp ${controller.pajak.toStringAsFixed(0)}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Bayar:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Rp ${controller.totalBayar.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 3. Tombol Bayar Sekarang
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        controller.keranjang.clear();
                        Get.back();
                        Get.snackbar(
                          "Pembayaran Berhasil",
                          "Terima kasih sudah berbelanja!",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      child: const Text(
                        "Bayar Sekarang",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

asdmakdmak
import 'dart:convert';

MakananModel makananModelFromJson(String str) => MakananModel.fromJson(json.decode(str));

class MakananModel {
  final List<Recipe> recipes;

  MakananModel({required this.recipes});

  factory MakananModel.fromJson(Map<String, dynamic> json) => MakananModel(
        recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
      );
}

class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final int caloriesPerServing;
  final String cuisine;
  final String image;
  final double rating;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.caloriesPerServing,
    required this.cuisine,
    required this.image,
    required this.rating,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        caloriesPerServing: json["caloriesPerServing"],
        cuisine: json["cuisine"],
        image: json["image"],
        rating: (json["rating"] as num).toDouble(),
      );
}
asdasdjn 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:belajarflutter/Controller/listmakanan_controller.dart';
import 'package:belajarflutter/pages/detail_makanan_page.dart';
import 'package:belajarflutter/pages/checkout_page.dart';

class ListmakananPage extends StatelessWidget {
  ListmakananPage({super.key});

  // Daftarkan controller pertama kali di sini
  final ListMakananController controller = Get.put(ListMakananController());

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
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Get.to(() => CheckoutPage()),
              ),
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
          itemCount: controller.listMakanan.length,
          itemBuilder: (context, index) {
            final makanan = controller.listMakanan[index];
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


askasdmkasm

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:belajarflutter/models/listmakanan_model.dart';

class ListMakananController extends GetxController {
  var listMakanan = <Recipe>[].obs;
  var isLoading = true.obs;
  var keranjang = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMakanan();
  }

  void getMakanan() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

      if (response.statusCode == 200) {
        final result = makananModelFromJson(response.body);
        listMakanan.assignAll(result.recipes);
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void tambahKeKeranjang(Recipe makanan) {
    keranjang.add(makanan);
    Get.snackbar("Berhasil", "${makanan.name} masuk keranjang");
  }

  void hapusDariKeranjang(int index) {
    keranjang.removeAt(index);
  }

  double get subtotal {
    double total = 0;
    for (var item in keranjang) {
      total += (item.caloriesPerServing * 100);
    }
    return total;
  }

  double get diskon {
    if (subtotal > 50000) {
      return subtotal * 0.10;
    }
    return 0;
  }

  double get pajak {
    return (subtotal - diskon) * 0.11;
  }

  double get totalBayar {
    return (subtotal - diskon) + pajak;
  }
}