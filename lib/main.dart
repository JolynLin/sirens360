import 'package:flutter/material.dart';
import 'settings.dart';
import 'history.dart';
import 'nearbyAlert.dart';
import 'LiveAlert.dart';
import 'HomePage.dart';
import 'splash.dart';
import 'riskdetail.dart';
import 'historydetail.dart';
import 'profile.dart';
import 'chatbot.dart';

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
        '/profile': (context) => const ProfilePage(),
        '/chatbot': (context) => const ChatbotPage(),
      },
    );
  }
}
