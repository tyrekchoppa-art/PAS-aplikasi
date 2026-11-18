import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_api_muhammadalfarrold_21/pages/drawer_pages.dart';

import 'package:http/http.dart' as http;
import 'package:pas_api_muhammadalfarrold_21/models/login_models.dart';

class LoginController extends GetxController {
  
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  var isloading = false.obs;
  var loginModel = Rxn<LoginModel>();

 void login() async {
   if (txtUsername.text.toString().isEmpty || txtPassword.text.toString().isEmpty) {
        Get.snackbar("error", "Username dan Password harus terisi");
   }else{
    try { 
      
      isloading.value = true;
      final url = Uri.parse('https://mediadwi.com/api/latihan/login');

      final response = await http.post(url, body:{
        'username': txtUsername.text.toString(),
        'password': txtPassword.text.toString()
      });

      isloading.value = false;
      if(response.statusCode == 200){
        loginModel.value = loginModelFromJson(response.body); 
        if(loginModel.value?.status == true){
          Get.snackbar("berhasil", loginModel.value!.message.toString());
          Get.off(() => DrawerPage());
        }else{
          Get.snackbar("gagal", loginModel.value!.message.toString());
        }

      }else{
        Get.snackbar("gagal", "cek internet connection");

      }
      }catch (e) {
        Get.snackbar("gagal", e.toString());
      }
   }

  }

}