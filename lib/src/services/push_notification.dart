import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:proyect_segu_v2/firebase_options.dart';

class PushNotificationService {
  static final FirebaseMessaging _firebasetessaging =
      FirebaseMessaging.instance;

  static String? token;

  static Future initializeApp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // push notifications
    await _firebasetessaging.requestPermission();
    token = await _firebasetessaging.getToken();
  }
}
