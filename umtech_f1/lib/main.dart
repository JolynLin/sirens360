import 'package:flutter/material.dart';
import 'package:umtech_f1/settings.dart';
import 'package:umtech_f1/history.dart';
import 'package:umtech_f1/nearbyAlert.dart';
import 'package:umtech_f1/LiveAlert.dart';
import 'package:umtech_f1/HomePage.dart';
import 'package:umtech_f1/splash.dart';
import 'package:umtech_f1/riskdetail.dart';
import 'package:umtech_f1/historydetail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DisasterGuard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/settings': (context) => const SettingsScreen(),
        '/history': (context) => const HistoryScreen(),
        '/nearby': (context) => const NearbyAlertsScreen(),
        '/live': (context) => const LiveAlertsScreen(),
        '/riskDetail': (context) => const RiskDetailScreen(),
        '/historydetail': (context) => const HistoryDetailScreen(),
        '/notifications': (context) => const Scaffold(
          body: Center(child: Text('Notifications Coming Soon')),
        ),
        '/profile': (context) => const Scaffold(
          body: Center(child: Text('Profile Coming Soon')),
        ),
        '/chatbot': (context) => const Scaffold(
          body: Center(child: Text('Chatbot Coming Soon')),
        ),
      },
    );
  }
}
