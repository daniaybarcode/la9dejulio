import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('La9 Bar'),
        backgroundColor: Colors.black38,
        iconTheme: IconThemeData(color: Colors.white), // Color del ícono de hamburguesa
        actions: [
          // Menú horizontal para pantallas grandes
          if (MediaQuery.of(context).size.width > 600) ...[
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Principal', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/proximos_eventos');
              },
              child: Text('Próximos Eventos', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/fotos');
              },
              child: Text('Fotos', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/gastronomia');
              },
              child: Text('Gastronomía', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/resena_historica');
              },
              child: Text('Reseña Histórica', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/contacto');
              },
              child: Text('Contacto', style: TextStyle(color: Colors.white)),
            ),
          ]
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepOrangeAccent,  // Fondo oscuro para el Drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black38,
                ),
                child: const Text(
                  'La9 Bar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.red),
                title: Text('Página Principal', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              ListTile(
                leading: Icon(Icons.event, color: Colors.red),
                title: Text('Próximos Eventos', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/proximos_eventos');
                },
              ),
              ListTile(
                leading: Icon(Icons.photo, color: Colors.red),
                title: Text('Fotos', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/fotos');
                },
              ),
              ListTile(
                leading: Icon(Icons.restaurant, color: Colors.red),
                title: Text('Gastronomía', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/gastronomia');
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.red),
                title: Text('Reseña Histórica', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/resena_historica');
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_mail, color: Colors.red),
                title: Text('Contacto', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/contacto');
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Bienvenidos a La9 Bar',
          style: TextStyle(
            fontSize: 24,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
