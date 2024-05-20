import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:proyect_segu_v2/src/config/app_theme.dart';
import 'package:proyect_segu_v2/src/services/push_notification.dart';
import 'package:proyect_segu_v2/src/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;
  static String? token;

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Evitará el desbordamiento al abrir el teclado
      body: Stack(
        children: [
          SingleChildScrollView(
            // Envuelve todo en un SingleChildScrollView
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      width: 200,
                      child: Image.asset('assets/images/inicio_sesion.png'),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildTextFormField(
                                controller: _emailController,
                                labelText: 'Email',
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress),
                            const SizedBox(
                              height: 12,
                            ),
                            buildTextFormField(
                                controller: _passwordController,
                                labelText: 'Password',
                                icon: Icons.lock,
                                obscureText: true,
                                validator: Validator.validationPassword),
                            _isLoading
                                ? const CircularProgressIndicator()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: SizedBox(
                                      height: 50, // Altura del botón
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue),
                                        child: const Text(
                                          "Iniciar sesion",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ))
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) + 800,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF6DA7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
        ],
      ),
    );
  }
}




// SEGUNDO TEST, CODIGO REGISTER_PAGE.DART
/*
   backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Registrar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildTextFormField(
                      controller: _usernameController,
                      labelText: 'Username',
                      icon: Icons.person_2_outlined,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    buildTextFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    buildTextFormField(
                      controller: _passwordController,
                      labelText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: Validator.validationPassword,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 300,
                          child: buildDropdownFormField(
                            labelText: 'Select',
                            icon: Icons.arrow_drop_down,
                            items: [
                              const DropdownMenuItem<String>(
                                value: 'tutor',
                                child: Text('Tutor'),
                              ),
                              const DropdownMenuItem<String>(
                                value: 'usuario',
                                child: Text('Usuario'),
                              ),
                            ],
                            value: _selectedRole?.toString(), // Convertir UserRole? a String?
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRole = newValue == 'tutor' ? UserRole.tutor : UserRole.user; // Asignar el valor correcto
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: submitRegister, // Corregir la llamada de la función
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  "Registrarse",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("¿No tienes una cuenta?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          child: const Text(
                            "Inicia sesión",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/


/*

TERCER TEST RESGISTER_PROVIDER.DART
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum UserRole { tutor, user }

class RegisterProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // RegisterProvider() {
  //   chekSign();
  // }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required UserRole role,
    // required Function onSuccess,
    required String token,
    required Function(String) onError,
  }) async {
    try {
      // convertir el username a minuculas
      final String usernameLowerCase = username.toLowerCase();

      //verificar si el usuario ya existe e n l base de datos de firebase
      final bool userExist = await chekUserExist(usernameLowerCase);
      if (userExist) {
        onError('El usuario ya existe');
        return;
      }

      // verificar las crdenciales del usuario
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user!;
      final String userId = user.uid;

      // GUARDAR DATOS DEL USUARIO EN LA BASE DE DATOS

      final userDatos = {
        'id': userId,
        'username': username,
        'username_lowercase': usernameLowerCase,
        'password': password,
        'email': email,
        'rol': role,
        'token': token
      };

      await _firestore.collection('users').doc(userId).set(userDatos);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('La contraseña es muy debil');
      } else if (e.code == 'email-already-in-use') {
        onError('El email ya esta en uso');
      } else {
        onError(e.toString());
      }
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
}

*/

/*
TEST GENREATE_QR_CODE.Dart
import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/services/generate_ids_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({super.key});

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  String codeQr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          codeQr.isEmpty
              ? Container()
              : QrImageView(
                  data: codeQr,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  String qrData = await GenerateIds().generateuserId();
                  setState(() {
                    codeQr = qrData;
                  });
                } catch (e) {
                  // Manejar el error aquí
                  print("Error al generar el código QR: $e");
                }
              },
              child: const Text(
                "Generar Qr",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


*/


/*

TEST scann_qr_code_page.DartPerformanceModeimport 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScann extends StatefulWidget {
  const QrScann({super.key});

  @override
  State<QrScann> createState() => _QrScannState();
}

class _QrScannState extends State<QrScann> {
  bool isCanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller =
      MobileScannerController(); // Create a controller

  String code = "";
  void closeScreen() {
    isCanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.blue : Colors.grey,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                controller.switchCamera();
              },
              icon: Icon(
                Icons.camera_front,
                color: isFrontCamera ? Colors.blue : Colors.grey,
              ))
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Coloca el codigo QR en el área",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "El scanneo se inicializara automaticamente",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )
              ],
            )),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                      ),
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;

                        if (image != null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text(
                                  "QR analizado correctamente",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                code,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 14, letterSpacing: 1),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

*/


/*
 V2
TEST scann_qr_code_page.DartPerformanceModeimport 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:proyect_segu_v2/src/widgets/overlay_scanner.dart';

class QrScann extends StatefulWidget {
  const QrScann({super.key});

  @override
  State<QrScann> createState() => _QrScannState();
}

class _QrScannState extends State<QrScann> {
  bool isCanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller =
      MobileScannerController(); // Create a controller

  String code = "";
  void closeScreen() {
    isCanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.blue : Colors.grey,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                controller.switchCamera();
              },
              icon: Icon(
                Icons.camera_front,
                color: isFrontCamera ? Colors.blue : Colors.grey,
              ))
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Coloca el codigo QR en el área",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "El scanneo se inicializara automaticamente",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )
              ],
            )),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        shape: QrScannerOverlayShape(
                          borderColor: Colors.white,
                          borderRadius: 10,
                          borderLength: 20,
                          borderWidth: 5,
                          cutOutSize: 200,
                        ),
                      ),
                      child: MobileScanner(
                        controller: MobileScannerController(
                          detectionSpeed: DetectionSpeed.noDuplicates,
                        ),
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          final Uint8List? image = capture.image;

                          if (image != null) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text(
                                    "QR analizado correctamente",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                code,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 14, letterSpacing: 1),
              ),
            ))
          ],
        ),
      ),
    );
  }
}



*/



/*
ULTIMA VERSION SCANN_QR-CODE

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScann extends StatefulWidget {
  const QrScann({super.key});

  @override
  State<QrScann> createState() => _QrScannState();
}

class _QrScannState extends State<QrScann> {
  bool isCanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller =
      MobileScannerController(); // Create a controller

  String code = "";
  void closeScreen() {
    isCanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Coloca el codigo QR en el área, para poder agregar un nuevo usuario",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "El scanneo se inicializara automaticamente",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )
              ],
            )),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                        returnImage: true,
                      ),
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;

                        if (image != null) {
                          print("contenmido ${barcodes.first.rawValue}");
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"))
                                ],
                                title: const Text(
                                  "Se agrego el usuario correctamente",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                code,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 14, letterSpacing: 1),
              ),
            ))
          ],
        ),
      ),
    );
  }
}



*/




/*
scann_qr_code_page.dart

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScann extends StatefulWidget {
  const QrScann({Key? key}) : super(key: key);

  @override
  State<QrScann> createState() => _QrScannState();
}

class _QrScannState extends State<QrScann> {
  bool isAlertDialogOpen =
      false; // Bandera para controlar si el AlertDialog está abierto
  MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "Scanner",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Coloca el código QR en el área para agregar un nuevo usuario",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "El escaneo se iniciará automáticamente",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true,
                ),
                onDetect: (capture) {
                  if (!isAlertDialogOpen) {
                    // Verificar si el AlertDialog no está abierto
                    setState(() {
                      isAlertDialogOpen =
                          true; // Establecer la bandera como abierta
                    });

                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;

                    if (image != null) {
                      print("Contenido: ${barcodes.first.rawValue}");
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Usuario agregado correctamente",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isAlertDialogOpen =
                                        false; // Establecer la bandera como cerrada
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cerrar"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Código: ",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




*/









/*
V2222222222222222222
scann_qr_code_page.dart

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScann extends StatefulWidget {
  const QrScann({Key? key}) : super(key: key);

  @override
  State<QrScann> createState() => _QrScannState();
}

class _QrScannState extends State<QrScann> {
  bool isAlertDialogOpen =
      false; // Bandera para controlar si el AlertDialog está abierto
  MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "Scanner",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Coloca el código QR en el área para agregar un nuevo usuario",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "El escaneo se iniciará automáticamente",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true,
                ),
                onDetect: (capture) {
                  if (!isAlertDialogOpen) {
                    // Verificar si el AlertDialog no está abierto
                    setState(() {
                      isAlertDialogOpen =
                          true; // Establecer la bandera como abierta
                    });

                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;

                    if (image != null) {
                      print("Contenido: ${barcodes.first.rawValue}");
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Usuario agregado correctamente",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isAlertDialogOpen =
                                        false; // Establecer la bandera como cerrada
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cerrar"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Código: ",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




*/



/*
REGLAS ANTERIORES DE FIRESTORE
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    // Regla para permitir a los usuarios autenticados leer y escribir en su propio documento de usuario
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
    
    // Regla para permitir a los usuarios autenticados leer todos los demás documentos
    match /{document=**} {
      allow read: if request.auth != null;
      
      // Bloquear escritura para todos los documentos, incluidos los del usuario
      allow write: if false;
    }
  }
}



*/


/*
body: Center(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
               stops: [
      0.2,
      0.5,
      0.8,
      0.7
    ],
  colors: [
    Colors.blue[50],
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300]
  ])),

  */




  /*

  LOGIN PAGE QUE FUNCIONA CORRECTAMENTE:
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_segu_v2/src/provider/login_provider.dart';
import 'package:proyect_segu_v2/src/screens/screen_tutor/home_tutor_page.dart';
import 'package:proyect_segu_v2/src/screens/screen_tutor/inicio_page_tutor.dart';
import 'package:proyect_segu_v2/src/services/push_notification.dart';
import 'package:proyect_segu_v2/src/utils/showsnacbar.dart';
import 'package:proyect_segu_v2/src/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;
  static String? token;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // LOGEARSE
  void onFormLogin(String usernameOrEmail, String password, context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String usernameOrEmailLower = usernameOrEmail.toLowerCase();

      loginProvider.loginUser(
        usernameOrEmail: usernameOrEmail,
        password: password,
        onSuccess: () async {
          // VERIFICAR SI EL USUARIO HA VERIFICADO SU CORREO ELECTRONICO
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null && user.emailVerified) {
            // SI EL USUAIRO HA VERIFICADO SU CORREO ELECTRONICO
            setState(() {
              _isLoading = false;
            });

            dynamic userData = await loginProvider.getUserData(user.email!);

            // CAMBIAR ESTADO DE AUNTENTICACION
            loginProvider.checkAuthState();

            // NAVEGAR AL INICIO
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HomePageTutor(
                userData: userData,
              );
            }));
          } else {
            // SI EL USUARIO NOHA VERIFICADO SU CORREO ELECTRONICO
            setState(() {
              _isLoading = false;
            });
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Verifica tu correo"),
                    content: const Text(
                        "Por favor verifica tu correo electronico para continuar"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Aceptar"))
                    ],
                  );
                });
          }
        },
        onError: (error) {
          showSnackbar(context, error);
        },
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Evitará el desbordamiento al abrir el teclado
      body: SingleChildScrollView(
        // Envuelve todo en un SingleChildScrollView
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  width: 200,
                  child: Image.asset('assets/images/inicio_sesion.png'),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextFormField(
                            controller: _emailController,
                            labelText: 'Email o Username',
                            icon: Icons.email,
                            inputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 12,
                        ),
                        buildTextFormField(
                            controller: _passwordController,
                            labelText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            validator: Validator.validationPassword),
                        const SizedBox(height: 20),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: SizedBox(
                                  height: 50, // Altura del botón
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      onFormLogin(_emailController.text,
                                          _passwordController.text, context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    child: const Text(
                                      "Iniciar sesion",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("¿No tienes una cuenta?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/register");
                                },
                                child: const Text(
                                  "Registrate",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  //topRight: Radius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  */


  
  /*
  SCANN_QR_CODE.DART CORRECTO

  import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScann extends StatefulWidget {
  const QrScann({Key? key}) : super(key: key);

  @override
  State<QrScann> createState() => _QrScannState();
}

class _QrScannState extends State<QrScann> {
  bool isAlertDialogOpen = false;
  MobileScannerController controller = MobileScannerController();
  String? codeText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "Scanner",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Coloca el código QR en el área para agregar un nuevo usuario",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "El escaneo se iniciará automáticamente",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true,
                ),
                onDetect: (capture) {
                  if (!isAlertDialogOpen) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    codeText = barcodes.first.rawValue;
                    if (image != null) {
                      print("Contenido: ${barcodes.first.rawValue}");

                      if (barcodes.first.rawValue != null &&
                          barcodes.first.rawValue!.contains("tutorado")) {
                        // Verificar si el código contiene la palabra "tutorado"
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Usuario agregado correctamente",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cerrar"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Mostrar AlertDialog indicando que el código no coincide con lo esperado
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Error",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              content: const Text(
                                "El código no coincide con lo esperado.",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cerrar"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Código:$codeText",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



  */




  /*
  GENERATE_QR_PAGE.DART


  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_segu_v2/src/provider/register_provider.dart';
import 'package:proyect_segu_v2/src/services/generate_ids_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({Key? key}) : super(key: key);

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  String codeQr = "";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String userId =
        args['id']; // Obtener el ID de usuario desde los argumentos

    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              textAlign: TextAlign.center,
              "Genera un código QR para vincular tu dispotitivo",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 109, 19, 212),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
              color: Colors.blue[50],
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  codeQr.isEmpty
                      ? Container()
                      : QrImageView(
                          data: codeQr,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          try {
                            final qrData = await GenerateIds().generateuserId();
                            setState(() {
                              codeQr = qrData;
                            });
                            await registerProvider.addCodeToUser(
                              userId: userId,
                              code: qrData,
                            );
                          } catch (e) {
                            // Manejar el error aquí
                            print('Error al agregar el código al usuario: $e');
                          }
                        },
                        child: const Text(
                          "Generar QR",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}




  */



  /*
  HOME_USER_PAGE.DART
  import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/routes/routes.dart';
import 'package:proyect_segu_v2/src/screens/screen_user/generate_qr_code_page.dart';

class HomePageUser extends StatefulWidget {
  final dynamic userData;
  const HomePageUser({Key? key, this.userData}) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int _selectedIndex = 0;

  final List<String> _drawerRoutes = [
    Routes.generateQr,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
    Navigator.pushNamed(
        context, _drawerRoutes[index]); // Navigate to selected route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: const [
                    0.2,
                    0.5,
                    0.8,
                    0.7
                  ],
                      colors: [
                    Colors.blue[50] ??
                        Colors
                            .transparent, // Valor predeterminado en caso de que Colors.blue[50] sea null
                    Colors.blue[100] ?? Colors.transparent,
                    Colors.blue[200] ?? Colors.transparent,
                    Colors.blue[300] ?? Colors.transparent,
                  ])),
              child: Text(
                "Bienvenido ${widget.userData['username']}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            _buildDrawerItem(Icons.qr_code, 'Generar QR', 0),
            _buildDrawerItem(Icons.account_box, 'Cuenta', 1),
          ],
        ),
      ),
      body: _buildPage(context, _selectedIndex),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    switch (_drawerRoutes[index]) {
      case Routes.generateQr:
        return const GenerateQr();
      default:
        return Container(); // Manejo para el caso de rutas desconocidas
    }
  }
}



  */


  /*
  app_routes.dart
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


  */



    /*
  generate_qr_code_page.dart
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_segu_v2/src/provider/register_provider.dart';
import 'package:proyect_segu_v2/src/services/generate_ids_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({Key? key}) : super(key: key);

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  String codeQr = "";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String userId =
        args['id']; // Obtener el ID de usuario desde los argumentos

    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              textAlign: TextAlign.center,
              "Genera un código QR para vincular tu dispotitivo",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 109, 19, 212),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
              color: Colors.blue[50],
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  codeQr.isEmpty
                      ? Container()
                      : QrImageView(
                          data: codeQr,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          try {
                            final qrData = await GenerateIds().generateuserId();
                            setState(() {
                              codeQr = qrData;
                            });
                            await registerProvider.addCodeToUser(
                              userId: userId,
                              code: qrData,
                            );
                          } catch (e) {
                            // Manejar el error aquí
                            print('Error al agregar el código al usuario: $e');
                          }
                        },
                        child: const Text(
                          "Generar QR",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

  


  */


  /*
  home_user_page.dart
  import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/routes/routes.dart';
import 'package:proyect_segu_v2/src/screens/screen_user/generate_qr_code_page.dart';

class HomePageUser extends StatefulWidget {
  final dynamic userData;
  const HomePageUser({Key? key, this.userData}) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int _selectedIndex = 0;

  final List<String> _drawerRoutes = [
    Routes.generateQr,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
    Navigator.pushNamed(context, _drawerRoutes[index],
        arguments: {"id": widget.userData['id']}); // Navigate to selected route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: const [
                    0.2,
                    0.5,
                    0.8,
                    0.7
                  ],
                      colors: [
                    Colors.blue[50] ??
                        Colors
                            .transparent, // Valor predeterminado en caso de que Colors.blue[50] sea null
                    Colors.blue[100] ?? Colors.transparent,
                    Colors.blue[200] ?? Colors.transparent,
                    Colors.blue[300] ?? Colors.transparent,
                  ])),
              child: Text(
                "Bienvenido ${widget.userData['username']}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            _buildDrawerItem(Icons.qr_code, 'Generar QR', 0),
            _buildDrawerItem(Icons.account_box, 'Cuenta', 1),
          ],
        ),
      ),
      body: _buildPage(context, _selectedIndex),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    switch (_drawerRoutes[index]) {
      case Routes.generateQr:
        return const GenerateQr();
      default:
        return Container(); // Manejo para el caso de rutas desconocidas
    }
  }
}


  */


  /*
  generate_qr_code_page.dart

  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_segu_v2/src/provider/register_provider.dart';
import 'package:proyect_segu_v2/src/services/generate_ids_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({Key? key}) : super(key: key);

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  String codeQr = "";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String userId =
        args['id']; // Obtener el ID de usuario desde los argumentos

    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              textAlign: TextAlign.center,
              "Genera un código QR para vincular tu dispotitivo",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 109, 19, 212),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
              color: Colors.blue[50],
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  codeQr.isEmpty
                      ? Container()
                      : QrImageView(
                          data: codeQr,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          try {
                            final qrData = await GenerateIds().generateuserId();
                            setState(() {
                              codeQr = qrData;
                            });
                            await registerProvider.addCodeToUser(
                              userId: userId,
                              code: qrData,
                            );
                          } catch (e) {
                            // Manejar el error aquí
                            print('Error al agregar el código al usuario: $e');
                          }
                        },
                        child: const Text(
                          "Generar QR",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}



  */