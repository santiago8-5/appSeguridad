import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/routes/routes.dart';

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
        arguments: {"id": widget.userData['id']});
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
                    Colors.blue[50] ?? Colors.transparent,
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
      default:
        return Container();
    }
  }
}
