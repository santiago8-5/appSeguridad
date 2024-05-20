import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthStatus { notAuthentication, cheeking, authentication }

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStatus authStatus = AuthStatus.notAuthentication;

  Future<void> loginUser({
    required String usernameOrEmail,
    required String password,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    try {
      authStatus = AuthStatus.cheeking;
      notifyListeners();

      //Tranformar los nombres a minusculas
      final String userNameOrEmaillowerCase = usernameOrEmail.toLowerCase();

      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('username_lowercase', isEqualTo: userNameOrEmaillowerCase)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        final String email = result.docs.first.get('email');
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        onSuccess();
        return;
      }

      // PARA EL INGRESO CONB EMAIL
      final QuerySnapshot resultEmail = await _firestore
          .collection('users')
          .where('username_lowercase', isEqualTo: userNameOrEmaillowerCase)
          .limit(1)
          .get();

      if (resultEmail.docs.isNotEmpty) {
        final String email = result.docs.first.get('email');
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        onSuccess();
        return;
      }

      onError('No se encontro el usuario');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        onError('Usuario o contraseña incorrecta');
      } else {
        onError(e.code.toString());
      }
    } catch (e) {
      onError(e.toString());
    }
  }

// VERIFICAR EL ESTADO DEL USUARIO

// OBTENER DATOS DEL USUARIO
  Future<dynamic> getUserData(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      final userData = result.docs[0].data();
      return userData;
    }
    return null;
  }

  void checkAuthState() async {}
}
