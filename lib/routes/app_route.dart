import 'package:get/get.dart';
import 'package:movies_app/auth/sign_in_screen.dart';
import 'package:movies_app/auth/sign_up_screen.dart';
import 'package:movies_app/auth/splash_screen.dart';
import 'package:movies_app/view/favorite_screen.dart';
import 'package:movies_app/view/home_screen.dart';
import 'package:movies_app/view/main_screen.dart';

class AppRoute {
  static const splash = '/splash';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const main = '/main';
  static const home = '/home';
  static const favorite = '/favorite';

  static final pages = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: signIn, page: ()=> SignInScreen()),
    GetPage(name: signUp, page: ()=> SignUpScreen()),
    GetPage(name: main, page: () => MainScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: favorite, page: ()=> FavoriteScreen())
  ];
}
