import 'package:uuid/uuid.dart';

class GenerateIds {
  String generateuserId() {
    String formatedUser;

    String uuid = const Uuid().v4();

    // Personalizacion del ID
    formatedUser = "tutorado-${uuid.substring(0, 5)}";

    // Return
    return formatedUser;
  }
}
