import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveAlertsScreen extends StatelessWidget {
  const LiveAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      LiveAlert(
        icon: Icons.local_fire_department,
        iconColor: Colors.deepOrange,
        title: 'High gas levels detected at',
        node: 'Taman Maju Node #372',
        timeAgo: '2 minutes ago',
      ),
      LiveAlert(
        icon: Icons.water_drop,
        iconColor: Colors.blue,
        title: 'Water level rising at',
        node: 'Taman Indah Node #164',
        timeAgo: '18 minutes ago',
      ),
      LiveAlert(
        icon: Icons.thermostat,
        iconColor: Colors.redAccent,
        title: 'Temperature anomaly detected at',
        node: 'Bukit Aman Node #290',
        timeAgo: '34 minutes ago',
      ),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 246, 246),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          itemCount: alerts.length + 1,
          separatorBuilder: (context, i) => i == 0 ? const SizedBox() : Divider(height: 32, color: Colors.grey[300]),
          itemBuilder: (context, i) {
            if (i == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Attention!!', style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.red)),
                  const SizedBox(height: 8),
                  Text(
                    'Please stay alert and follow safety instructions.',
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            }
            final alert = alerts[i - 1];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: alert.iconColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(alert.icon, color: alert.iconColor, size: 36),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(alert.title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(alert.node, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 8),
                      Text(alert.timeAgo, style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700])),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3, // Live tab
          onTap: (index) {
            if (index == 0) Navigator.pushNamed(context, '/home');
            if (index == 1) Navigator.pushNamed(context, '/nearby');
            if (index == 2) Navigator.pushNamed(context, '/history');
            if (index == 4) Navigator.pushNamed(context, '/chatbot');
          },
          selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.inter(),
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.pink),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map, color: Colors.green),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, color: Colors.purple),
              label: 'Data',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning, color: Colors.amber),
              label: 'Live',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.blue),
              label: 'AI Chatbot',
            ),
          ],
        ),
      ),
    );
  }
}

class LiveAlert {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String node;
  final String timeAgo;
  LiveAlert({required this.icon, required this.iconColor, required this.title, required this.node, required this.timeAgo});
}
