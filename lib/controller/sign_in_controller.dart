import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies_app/routes/app_route.dart';
import 'package:movies_app/services/local_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final _supabase = Supabase.instance.client;
  var isLoading = false.obs;

  Future<void> signIn(String email, String password) async{
    try {
      if(!formKey.currentState!.validate()) return;

      isLoading.value = true;
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password);

      if(response.session != null ){
        LocalStorageService.instan.setString('userId', response.user?.id?? "");
        Get.offAllNamed(AppRoute.main);
      }
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}