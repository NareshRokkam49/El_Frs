import 'package:entrolabs_attadance/view/dash_board_screens/create_worklog_screen.dart';
import 'package:entrolabs_attadance/view/dash_board_screens/leaves_histry_list_screen.dart';
import 'package:entrolabs_attadance/view/login_screen/forgot_password_screen.dart';
import 'package:entrolabs_attadance/view/login_screen/frs_intigration_screen.dart';
import 'package:entrolabs_attadance/view/login_screen/get_start_screen.dart';
import 'package:entrolabs_attadance/view/login_screen/otp_screen.dart';
import 'package:entrolabs_attadance/view/login_screen/reset_password_screen.dart';
import 'package:entrolabs_attadance/view/profile_screens/change_password_screen.dart';
import 'package:entrolabs_attadance/view/profile_screens/profile_screen.dart';
import 'package:entrolabs_attadance/view/splash_screen.dart';
import 'package:get/get.dart';
import '../view/dash_board_screens/apply_leaves_screen.dart';
import '../view/dash_board_screens/botton_navigation_screen.dart';
import '../view/dash_board_screens/notification_screen.dart';
import '../view/login_screen/login_screen.dart';
import '../view/login_screen/type_of_login_screen.dart';
import '../view/profile_screens/edit_profile_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    ///login Module
     GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen(),transition: Transition.rightToLeftWithFade,),
      GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen(),transition: Transition.rightToLeftWithFade,),
        GetPage(name: AppRoutes.typeOfloginScreen, page: () => TypeOfLoginScreen(),transition: Transition.rightToLeftWithFade,),
       GetPage(name: AppRoutes.frsIntegrationScreen, page: () => FrsIntegrationScreen(),transition: Transition.rightToLeftWithFade,),
       GetPage(name: AppRoutes.forgotPasswordScreen, page: () => ForgotPasswordScreen(),transition: Transition.rightToLeftWithFade,),
       GetPage(name: AppRoutes.otpScreen, page: () => OtpScreenScreen(),transition: Transition.rightToLeftWithFade,),
       GetPage(name: AppRoutes.resetPasswordScreen, page: () => ResetPasswordScreen(),transition: Transition.rightToLeftWithFade,),
       GetPage(name: AppRoutes.getStartScreen, page: () => GetStartScreen(),transition: Transition.rightToLeftWithFade),

// btn screens
    GetPage(
      name: AppRoutes.btmNavigationScreen,
      page: () => BottomNavigationScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.leaveHistoryScreen,
      page: () => LeaveHistoryScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.applyLeavesScreen,
      page: () => ApplyLeavesScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
        name: AppRoutes.createWorkLogScreen, page: () => CreateWorkLogScreen()),

//profile screens
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.editProfileScreen,
      page: () => EditProfileScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
