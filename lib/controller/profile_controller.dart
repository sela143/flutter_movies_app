import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/routes/app_route.dart';
import 'package:movies_app/services/local_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController{
  final _supbase = Supabase.instance.client;
  final nameCtl = TextEditingController();
  var isLoading = false.obs;
  RxString name = ''.obs;
  RxString imageUrl = ''.obs;

  @override
  onInit(){
    super.onInit();
    loadProfile();
  }
  Future<void> signOut() async{
    await _supbase.auth.signOut();
    LocalStorageService.instan.remove("userId");
    Get.offAllNamed(AppRoute.signIn);
  }

  //get data form table supabase
  Future<void> loadProfile() async{
    try {
      isLoading.value = true;
      final userId = _supbase.auth.currentUser?.id;
      if(userId == null) return;
      final response = await _supbase
          .from("person")
          .select()
          .eq("id", userId)
          .single();
      name.value = response['username'] ?? "";
      final fileName = response['image'] as String?;
        if(fileName != null && fileName.isNotEmpty){
          final signedUrl = await _supbase.storage
              .from('images')
              .createSignedUrl(fileName, 3000);
          imageUrl.value = signedUrl;
        }else{
          imageUrl.value = '';
        }
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  //upsert name to supabase
  Future<void> setName(String newName)async {
    final userId = _supbase.auth.currentUser?.id;
    if(userId == null) return;

    isLoading.value = true;
    try{
      await _supbase.from("person").upsert({
        'id':userId,
        'username':newName,
        'updated_at':DateTime.now().toIso8601String(),
      });
      name.value = newName;
      name.reactive();
      Get.back();
    }catch(e){
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  //upload image profile to table supabase
  Future<void> uploadImage() async{
    final userId = _supbase.auth.currentUser?.id;
    if(userId == null) return;

    ImagePicker? picker = ImagePicker();
    XFile? pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickerFile == null) return;

    final fileBytes = await pickerFile.readAsBytes();
    final fileName = 'public/image_$userId.png';

    try {
      isLoading.value = true;
      final profileReponse = await _supbase
            .from('person')
            .select('image')
            .eq('id', userId)
            .single();
      final oldImage = profileReponse['image'] as String?;

      //buckets
      await _supbase.storage
            .from('images')
            .updateBinary(
              fileName,
              fileBytes,
              fileOptions: FileOptions(upsert: true));

      if(oldImage != null && oldImage != fileName){
        await _supbase.storage.from('images').remove([oldImage]);
      }
      await _supbase
            .from('person')
            .update({'image': fileName})
            .eq('id', userId);
            
      await loadProfile();
      
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}