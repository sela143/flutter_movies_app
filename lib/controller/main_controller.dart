import 'package:get/get.dart';

class MainController extends GetxController{
  final _selectIndex = 0.obs;
  get getSelectIndex => _selectIndex.value;

  void changeIndex(index){
    _selectIndex.value = index;
  }
}