import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/routine_page.dart';
import 'pages/health_page.dart';
import 'pages/calendar_page.dart';
import 'pages/notices_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MaterialApp(
        title: 'CMEI App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        initialRoute: '/home',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/routine': (context) => RoutinePage(),
          '/health': (context) => SaudePage(),
          '/calendar': (context) => CalendarioPage(),
          '/notices': (context) => NoticesPage(),
        },
      ),
    );
  }
}
