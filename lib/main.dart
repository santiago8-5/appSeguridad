import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_segu_v2/src/provider/login_provider.dart';
import 'package:proyect_segu_v2/src/provider/provider_funtions_tutor/register_tutorado_provider.dart';
import 'package:proyect_segu_v2/src/provider/register_provider.dart';
import 'package:proyect_segu_v2/src/routes/app_routes.dart';
import 'package:proyect_segu_v2/src/routes/routes.dart';
import 'package:proyect_segu_v2/src/services/push_notification.dart';

void main() async {
  //Intl.defaultLocale = "es_ES";
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => LoginProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => RegisterProvider()),
        ChangeNotifierProvider(
            lazy: false, create: (_) => RegisterTutoradoProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.login,
        routes: appRoutes,
      ),
    );
  }
}
