import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:proyect_segu_v2/src/provider/provider_funtions_tutor/register_tutorado_provider.dart';

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
                        final registerTutoradoProvider =
                            Provider.of<RegisterTutoradoProvider>(context,
                                listen: false);
                        registerTutoradoProvider
                            .registrarTutorado(
                          userId:
                              'userId', // Cambiar esto por el userId real del tutor
                          codigoQR: barcodes.first.rawValue!,
                        )
                            .then((_) {
                          // Mostrar AlertDialog indicando que el usuario tutorado fue registrado correctamente
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
                        }).catchError((error) {
                          // Mostrar AlertDialog indicando que ocurrió un error al registrar al usuario tutorado
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
                                content: Text(
                                  "Ocurrió un error al registrar al usuario tutorado: $error",
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
                        });
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
