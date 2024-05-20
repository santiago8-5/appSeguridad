import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterTutoradoProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registrarTutorado(
      {required String userId, required String codigoQR}) async {
    try {
      // Verificar si el código QR ya está asociado a algún tutorado
      final QuerySnapshot result = await _firestore
          .collection('tutorados_qr_codes')
          .where('codigo', isEqualTo: codigoQR)
          .limit(1)
          .get();

      // Si el código QR ya está asociado a un tutorado, no se puede registrar
      if (result.docs.isNotEmpty) {
        throw Exception('El código QR ya está registrado.');
      }

      // Registrar el tutorado asociando su ID con el código QR
      final tutoradoData = {'userId': userId, 'codigo': codigoQR};
      await _firestore.collection('tutorados_qr_codes').add(tutoradoData);
    } catch (e) {
      // Manejar el error aquí
      print('Error al registrar el tutorado: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>?> obtenerDatosTutorado(String codigoQR) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('tutorados_qr_codes')
          .where('codigo', isEqualTo: codigoQR)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        final String userId = result.docs.first.get('userId');
        final DocumentSnapshot userData =
            await _firestore.collection('users').doc(userId).get();
        final tutoradoData = userData.data();
        return tutoradoData as Map<String,
            dynamic>?; // Asegurarse de que el tipo de retorno sea Map<String, dynamic>?
      }
      return null;
    } catch (e) {
      print('Error al obtener los datos del tutorado: $e');
      throw e;
    }
  }
}
