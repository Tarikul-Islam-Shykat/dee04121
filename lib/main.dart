import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import 'package:prettyrini/feature/account/ui/account_ui.dart';
import 'package:prettyrini/feature/auth/screen/login_screen.dart';
import 'package:prettyrini/feature/auth/screen/sign_up_screen.dart';
import 'package:prettyrini/feature/bottom_nav/ui/bottom_nav_screen.dart';
import 'package:prettyrini/feature/daily_practice/ui/daily_ui_page.dart';
import 'package:prettyrini/feature/daily_practice_quiz_page/ui/daily_quiz_screen.dart';
import 'package:prettyrini/feature/home_page/ui/home_page.dart';
import 'package:prettyrini/feature/leader_board/ui/leader_board_ui.dart';
import 'package:prettyrini/feature/progress_report/ui/progress_report_page.dart';
import 'package:prettyrini/feature/quiz_page/ui/quiz_ui.dart';
import 'package:prettyrini/feature/role/ui/role_ui.dart';
import 'package:prettyrini/feature/settings/ui/profile_screen.dart';
import 'package:prettyrini/feature/settings/ui/settings_screen.dart';
import 'package:prettyrini/feature/welome/view/welcome_screen.dart';
import 'package:prettyrini/route/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/const/app_colors.dart';

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
        getPages: AppRoute.routes,
        initialRoute: AppRoute.welcomeScreen,
        builder: EasyLoading.init(),

        //  home: LoginPage(),
        // home: ForgetPaswordScreen(),
        //  home: ResetPassword(),
        //  home: OtpVerificationPage(),
        //  home: SignUpScreen(),
        // home: QuizLevelScreen(),
        //  home: QuizScreen(),
        //home: DailyPracticesPage(),
        // home: DailyQuizScreen(),
        //  home: ProgressReportPage(),
        //home: WelcomeScreen(),
        //  home: RoleScreen(),
        // home: LeaderboardScreen(),
        //   home: SettingsScreen(),
        //  home: ProfileScreen(),
        // home: HomePage(),
        // home: AccountPage(),
        // home: BottomNavScreen(),
      ),
    );
  }
}
