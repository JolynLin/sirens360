import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiskDetailScreen extends StatelessWidget {
  const RiskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    String areaName = 'Area Name';
    String nodeCode = '';
    if (args is String) {
      // If the argument is a pin id, find the area name and node code
      if (args.startsWith('gas')) {
        nodeCode = 'Node #${args.toUpperCase()}';
        // Example: match gas2 to Taman Maju
        if (args == 'gas2') areaName = 'Taman Maju';
        else areaName = 'Unknown Area';
      } else if (args == 'disaster1') {
        nodeCode = 'Node #DISASTER1';
        areaName = 'Taman Indah';
      } else if (args == 'safe1') {
        areaName = 'Bukit Aman';
      } else if (args == 'warn1') {
        areaName = 'Jalan Damai';
      } else if (args == 'water1') {
        areaName = 'Kampung Baru';
      } else if (args == 'refuge2') {
        areaName = 'Desa Jaya';
      } else if (args == 'temp2') {
        areaName = 'Bandar Utama';
      } else if (args == 'water2') {
        areaName = 'Sri Hartamas';
      } else {
        areaName = args;
      }
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 246, 246),
      body: SafeArea(
        child: Column(
          children: [
            // Node code and area info card
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (nodeCode.isNotEmpty)
                      Text(nodeCode, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey[800])),
                    Text(areaName, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 26)),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StatusChip(label: 'Alert', color: Colors.red, icon: Icons.warning_amber_rounded),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(Icons.battery_full, color: Colors.green, size: 18),
                            const SizedBox(width: 4),
                            Text('87%', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green)),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.grey, size: 18),
                            const SizedBox(width: 4),
                            Text('2m ago', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey[700])),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey[300], height: 1),
            const SizedBox(height: 8),
            // Data cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: [
                  _DataCard(
                    title: 'Gas Level',
                    value: '473 ppm',
                    valueColor: Colors.red,
                    icon: Icons.local_fire_department,
                    chartColor: const Color.fromARGB(255, 213, 127, 106),
                  ),
                  const SizedBox(height: 20),
                  _DataCard(
                    title: 'Temperature',
                    value: '28.3 °C',
                    valueColor: Colors.black,
                    icon: Icons.thermostat,
                    chartColor: Colors.orange,
                  ),
                  const SizedBox(height: 20),
                  _DataCard(
                    title: 'Water Level',
                    value: '1.2 m',
                    valueColor: Colors.black,
                    icon: Icons.water,
                    chartColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
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
          currentIndex: 2, // Data tab
          onTap: (index) {
            if (index == 0) Navigator.pushNamed(context, '/home');
            if (index == 1) Navigator.pushNamed(context, '/nearby');
            if (index == 3) Navigator.pushNamed(context, '/live');
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

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  const _StatusChip({required this.label, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class _MetaInfo extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _MetaInfo({required this.label, required this.value, this.valueColor});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600])),
          const SizedBox(height: 2),
          Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15, color: valueColor)),
        ],
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  final IconData icon;
  final Color chartColor;
  const _DataCard({required this.title, required this.value, required this.valueColor, required this.icon, required this.chartColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 8),
                Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24, color: valueColor)),
                const SizedBox(height: 12),
                // Taller mock chart
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [chartColor.withOpacity(0.2), chartColor.withOpacity(0.05)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomPaint(
                    painter: _MockChartPainter(chartColor),
                    size: const Size(double.infinity, 70),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: chartColor.withOpacity(0.13),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: chartColor, size: 32),
          ),
        ],
      ),
    );
  }
}

class _MockChartPainter extends CustomPainter {
  final Color color;
  _MockChartPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.cubicTo(size.width * 0.2, size.height * 0.5, size.width * 0.4, size.height * 0.8, size.width * 0.6, size.height * 0.3);
    path.cubicTo(size.width * 0.8, size.height * 0.1, size.width, size.height * 0.6, size.width, size.height * 0.4);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}