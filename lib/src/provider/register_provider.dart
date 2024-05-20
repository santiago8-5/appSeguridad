import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum UserRole { tutor, user }

class RegisterProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _codeQr = ''; // Propiedad para almacenar el código QR

  // Getter para acceder al código QR
  String get codeQr => _codeQr;

  // RegisterProvider() {
  //   chekSign();
  // }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required UserRole role,
    required String token,
    required Function(String) onError,
  }) async {
    try {
      // Convertir el username a minúsculas
      final String usernameLowerCase = username.toLowerCase();

      // Verificar si el usuario ya existe en la base de datos de Firebase
      final bool userExists = await chekUserExist(usernameLowerCase);
      if (userExists) {
        onError('El usuario ya existe');
        return;
      }

      // Verificar si el email ya está en uso
      final bool emailExists = await chekEmailExist(email);
      if (emailExists) {
        onError('El email ya está en uso');
        return;
      }

      // Crear usuario en Firebase Authentication
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user!;
      final String userId = user.uid;

      // Guardar datos del usuario en la base de datos Firestore
      final userDatos = {
        'id': userId,
        'username': username,
        'username_lowercase': usernameLowerCase,
        'password': password,
        'email': email,
        'rol': role.toString(), // Convertir el rol a String
        'token': token
      };

      await _firestore.collection('users').doc(userId).set(userDatos);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('La contraseña es muy débil');
      } else if (e.code == 'email-already-in-use') {
        onError('El email ya está en uso');
      } else {
        onError(e.message ?? 'Error al registrar el usuario');
      }
    } on FirebaseException catch (e) {
      onError(e.message ?? 'Error al registrar el usuario');
    } catch (e) {
      onError('Error al registrar el usuario');
    }
  }

  //metodo para verificar si ya existe en la base de datos
  Future<bool> chekUserExist(String username) async {
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  // METODO PARA VERIFICAR SI EL EMAIL YA EXISTE
  Future<bool> chekEmailExist(String email) async {
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  // METODO PARA AGREGAR EL CODE AL USUARIO
  Future<void> addCodeToUser(
      {required String userId, required String code}) async {
    try {
      // Eliminar el código QR anterior del usuario
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'code': FieldValue.delete()});

      // Agregar el nuevo código QR al usuario
      await _firestore.collection('users').doc(userId).update({'code': code});
    } catch (e) {
      // Manejar el error aquí
      print('Error al agregar el código al usuario: $e');
      throw e; // Re-lanzar el error para que el llamador pueda manejarlo
    }
  }
}
