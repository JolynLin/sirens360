import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryDetailScreen extends StatelessWidget {
  const HistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    String area = 'Taman Indah';
    String place = 'Node #164';
    String status = 'Warning';
    if (args != null && args is HistoryArea) {
      area = args.area;
      place = args.place;
      status = args.status;
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 246, 246),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            const SizedBox(height: 18),
            Center(
              child: Column(
                children: [
                  Text(area, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 26)),
                  const SizedBox(height: 6),
                  Text(place, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueGrey)),
                  const SizedBox(height: 10),
                  _StatusChip(status: status),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Gas bar chart
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gas Level (ppm)', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(
                        height: 180,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 400,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, reservedSize: 32, getTitlesWidget: (v, meta) => Text(v.toInt().toString(), style: GoogleFonts.inter(fontSize: 12))),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta) {
                                  const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(days[v.toInt()], style: GoogleFonts.inter(fontSize: 12)),
                                  );
                                }),
                              ),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: [
                              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 120, color: Colors.blue)]),
                              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 180, color: Colors.blue)]),
                              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 220, color: Colors.blue)]),
                              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 300, color: Colors.blue)]),
                              BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 390, color: Colors.blue)]),
                              BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 320, color: Colors.blue)]),
                              BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 270, color: Colors.blue)]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Avg/Max Gas cards
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Avg. Gas Level', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700])),
                            const SizedBox(height: 6),
                            Text('312 ppm', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
                            Text('+26% vs. last week', style: GoogleFonts.inter(fontSize: 13, color: Colors.green)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Max Gas Level', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700])),
                            const SizedBox(height: 6),
                            Text('473 ppm', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
                            Text('+42% vs. last week', style: GoogleFonts.inter(fontSize: 13, color: Colors.green)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Temperature line chart
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Temperature Readings', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(
                        height: 120,
                        child: LineChart(
                          LineChartData(
                            minY: 20,
                            maxY: 40,
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, reservedSize: 32, getTitlesWidget: (v, meta) => Text(v.toInt().toString(), style: GoogleFonts.inter(fontSize: 12))),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta) {
                                  const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(days[v.toInt()], style: GoogleFonts.inter(fontSize: 12)),
                                  );
                                }),
                              ),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 28),
                                  FlSpot(1, 29),
                                  FlSpot(2, 27),
                                  FlSpot(3, 31),
                                  FlSpot(4, 33),
                                  FlSpot(5, 32),
                                  FlSpot(6, 30),
                                ],
                                isCurved: true,
                                color: Colors.orange,
                                barWidth: 3,
                                dotData: FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Water level line chart
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Water Level (m)', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(
                        height: 120,
                        child: LineChart(
                          LineChartData(
                            minY: 0,
                            maxY: 2,
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, reservedSize: 32, getTitlesWidget: (v, meta) => Text(v.toStringAsFixed(1), style: GoogleFonts.inter(fontSize: 12))),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta) {
                                  const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(days[v.toInt()], style: GoogleFonts.inter(fontSize: 12)),
                                  );
                                }),
                              ),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 1.0),
                                  FlSpot(1, 1.2),
                                  FlSpot(2, 1.1),
                                  FlSpot(3, 1.3),
                                  FlSpot(4, 1.5),
                                  FlSpot(5, 1.4),
                                  FlSpot(6, 1.2),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 3,
                                dotData: FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
            if (index == 2) Navigator.pushNamed(context, '/history');
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

class HistoryArea {
  final String area;
  final String place;
  final String status;
  HistoryArea({required this.area, required this.place, required this.status});
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  Color get color {
    switch (status) {
      case 'Normal':
        return Colors.green;
      case 'Warning':
        return Colors.orange;
      case 'Alert':
        return Colors.red;
      case 'Refuge':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(status, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: color)),
    );
  }
}
