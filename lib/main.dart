import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import 'package:prettyrini/feature/auth/screen/forget_pasword_screen.dart';
import 'package:prettyrini/feature/auth/screen/login_screen.dart';
import 'package:prettyrini/feature/auth/screen/new_password.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import 'package:prettyrini/feature/auth/screen/reset_password.dart';
import 'package:prettyrini/feature/auth/screen/sign_up_screen.dart';
import 'package:prettyrini/feature/dashboard/ui/product_home_screen.dart';
import 'package:prettyrini/feature/post/ui/post_ui.dart';
import 'package:prettyrini/feature/subscription_page/view/subscription_screen.dart';
import 'package:prettyrini/feature/welome/view/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/const/app_colors.dart';
import 'route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configEasyLoading();
  await SharedPreferences.getInstance();
  Get.put(ThemeController());
  runApp(const MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.grayColor
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foot Fitness',
        // getPages: AppRoute.routes,
        // initialRoute: AppRoute.splashScreen,
        // builder: EasyLoading.init(),

        // home: LoginPage(),
        // home: ForgetPaswordScreen(),
        //  home: ResetPassword(),
      //  home: OtpVerificationPage(),
      home: SignUpScreen(),
      ),
    );
  }
}
