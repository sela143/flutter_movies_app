
import 'package:get/get.dart';
import 'package:movies_app/routes/app_route.dart';
import 'package:movies_app/services/local_service.dart';

class SplashController extends GetxController{
  final userId = "".obs;

  @override
  void onInit() {
    LocalStorageService.instan.init();
    userId.value = LocalStorageService.instan.getString("userId")??"";

    Future.delayed(
      const Duration(seconds: 3),(){
        if(userId.value == ""){
          Get.offAllNamed(AppRoute.signIn);
        }else{
          Get.offAllNamed(AppRoute.main);
        }
      }
    );
    super.onInit();
  }
}