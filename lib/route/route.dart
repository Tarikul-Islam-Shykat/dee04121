import 'package:get/get.dart';
import 'package:prettyrini/feature/welome/view/welcome_screen.dart';
import '../feature/auth/screen/forget_pasword_screen.dart';
import '../feature/auth/screen/login_screen.dart';
import '../feature/auth/screen/reset_password.dart';
import '../feature/splash_screen/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String loginScreen = "/loginScreen";
  static String forgetScreen = "/forgetScreen";
  static String resetPassScreen = "/resetPassScreen";

  static String welcomeScreen = '/welComScreen';

  static String getSplashScreen() => splashScreen;
  static String getWelcomeScreen() => welcomeScreen;

  static String getLoginScreen() => loginScreen;

  static String getForgetScreen() => forgetScreen;

  static String getResetPassScreen() => resetPassScreen;

  static List<GetPage> routes = [
    GetPage(name: welcomeScreen, page: () => const WelcomeScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginPage()),
    GetPage(name: forgetScreen, page: () => const ForgetPaswordScreen()),
    GetPage(name: resetPassScreen, page: () => ResetPassword()),
  ];
}
