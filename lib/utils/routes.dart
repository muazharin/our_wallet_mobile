import 'package:get/get.dart';
import 'package:getx/views/auth/auth_create_password.dart';
import 'package:getx/views/auth/auth_login.dart';
import 'package:getx/views/auth/auth_register.dart';
import 'package:getx/views/auth/auth_register_form.dart';
import 'package:getx/views/menu/main_menu.dart';
import 'package:getx/views/splash_screen.dart';
import 'package:getx/views/wallet/wallet_add.dart';
import 'package:getx/views/wallet/wallet_detail.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: "/main_menu",
    page: () => const MainMenu(),
    transition: Transition.zoom,
  ),
  GetPage(
    name: "/splash_screen",
    page: () => const SplashScreen(),
    transition: Transition.fade,
  ),

  // Authentication
  GetPage(
    name: "/auth_login",
    page: () => const AuthLogin(),
    transition: Transition.zoom,
  ),
  GetPage(
    name: "/auth_register",
    page: () => const AuthRegister(),
  ),
  GetPage(
    name: "/auth_register_form",
    page: () => const AuthRegisterForm(),
  ),
  GetPage(
    name: "/auth_create_password",
    page: () => const AuthCreatePassword(),
  ),

  // Wallet
  GetPage(
    name: "/wallet_add",
    page: () => const WalletAdd(),
  ),
  GetPage(
    name: "/wallet_detail",
    page: () => const WalletDetail(),
  ),
];
