import 'package:flutter/material.dart';
import 'pages/routine_page.dart';

void main() {
  runApp(CmeiApp());
}

class CmeiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMEI App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/routine': (context) => RoutinePage(),
      },
    );
  }
}

// Placeholder login page (to be implemented next)
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          child: Text('Simular Login'),
        ),
      ),
    );
  }
}

// Placeholder home page with basic tabs (to be replaced)
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CMEI Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/routine'),
              child: Text('Ir para Rotina'),
            ),
          ],
        ),
      ),
    );
  }
}
