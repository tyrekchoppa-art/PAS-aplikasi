import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_api_muhammadalfarrold_21/models/feat_model.dart';

class FeatController extends GetxController {
  var listFeat = <Team>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchFeat();
  }

  void fetchFeat() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

      if (response.statusCode == 200) {
        final result = premierLeagueModelFromJson(response.body);
        listFeat.assignAll(result.teams);
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}