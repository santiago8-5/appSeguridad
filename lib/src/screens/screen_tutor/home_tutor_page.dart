import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/routes/routes.dart';
import 'package:proyect_segu_v2/src/screens/screen_tutor/scann_qr_code_page.dart';

class HomePageTutor extends StatefulWidget {
  final dynamic userData;
  const HomePageTutor({Key? key, this.userData}) : super(key: key);

  @override
  _HomePageTutorState createState() => _HomePageTutorState();
}

class _HomePageTutorState extends State<HomePageTutor> {
  int _selectedIndex = 0;

  final List<String> _drawerRoutes = [
    Routes.qrScann,
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
            _buildDrawerItem(Icons.qr_code_scanner, 'Registrar usuario', 0),
            _buildDrawerItem(Icons.people, 'Usuarios', 1),
            _buildDrawerItem(Icons.location_history, 'Ubicaciones', 2),
            _buildDrawerItem(Icons.gps_fixed, 'Tiempo real', 3),
            _buildDrawerItem(Icons.map_sharp, 'Zonas seguras', 4),
            _buildDrawerItem(Icons.exit_to_app, 'Cerrar Sesion', 5)
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
      case Routes.qrScann:
        return const QrScann();
      default:
        return Container(); // Manejo para el caso de rutas desconocidas
    }
  }
}
