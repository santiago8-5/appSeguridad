import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/routes/routes.dart';
import 'package:proyect_segu_v2/src/screens/login_and_register/login/login_page.dart';
import 'package:proyect_segu_v2/src/screens/login_and_register/register/register_page.dart';
import 'package:proyect_segu_v2/src/screens/screen_tutor/home_tutor_page.dart';
import 'package:proyect_segu_v2/src/screens/screen_tutor/scann_qr_code_page.dart';
import 'package:proyect_segu_v2/src/screens/screen_user/generate_qr_code_page.dart';
import 'package:proyect_segu_v2/src/screens/screen_user/home_user_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.login: (_) => const LoginPage(),
  Routes.register: (_) => const RegisterPage(),
  Routes.generateQr: (_) => const GenerateQr(),
  Routes.qrScann: (_) => const QrScann(),
  Routes.homeTutor: (_) => const HomePageTutor(),
  Routes.homeUser: (_) => const HomePageUser(),
};
