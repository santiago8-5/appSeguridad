import 'package:flutter/material.dart';

class InicioPageTutor extends StatefulWidget {
  final dynamic userData;
  const InicioPageTutor({Key? key, this.userData}) : super(key: key);

  @override
  State<InicioPageTutor> createState() => _InicioPageTutorState();
}

class _InicioPageTutorState extends State<InicioPageTutor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenido ${widget.userData['username']}"),
            Text("Email${widget.userData['email']}"),

            //Codigo PRUEBA
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/generateQr",
                  arguments: {
                    "id": widget.userData['id']
                  }, // Pasar el ID de usuario como argumento
                );
              },
              child: Text("Qr"),
            )

            // FIN CODIGO PRUEBA
          ],
        ),
      ),
    );
  }
}
