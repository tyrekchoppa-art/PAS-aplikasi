import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_api_muhammadalfarrold_21/models/makanan_model.dart';

class HomePageController extends GetxController {
  var listData = <Recipe>[].obs;
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
        listData.assignAll(result.recipes);
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