import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/routes/app_route.dart';
import 'package:movies_app/services/local_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final cfPasswordCtl = TextEditingController();
  final _supabase = Supabase.instance.client;

  var isLoading = false.obs;

  Future<void> signUp(String email, String password) async{
    try {
      if(!formKey.currentState!.validate()) return;

      isLoading.value = true;
      //check password == cfPassword
      if(password != cfPasswordCtl.text){
        Get.snackbar("Error", "Password does not match");
        return;
      }

      final response = await _supabase.auth.signUp(
          email: email, 
          password: password);
      
      if(response.user != null){
        LocalStorageService.instan.setString("userId", response.user?.id?? "");
        Get.offAllNamed(AppRoute.signIn);
      }
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}