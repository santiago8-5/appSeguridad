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
    Map<String, dynamic>? args;
    String userId = '';

    try {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      userId = args['id'];
    } catch (e) {
      print('Error al obtener los argumentos: $e');
    }

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
              "Genera un código QR para vincular tu dispositivo",
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
