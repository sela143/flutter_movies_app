import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigetionController extends GetxController{
  
  final _selectedIndex = 0.obs;  

  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int index) => _selectedIndex.value = index;

  List<IconData> icons = [
    Icons.home_filled,
    Icons.person
  ];
}