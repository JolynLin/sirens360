import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<HistoryArea> _areas = [
    HistoryArea(area: 'Taman Maju', place: 'Node #372', status: 'Normal'),
    HistoryArea(area: 'Taman Indah', place: 'Node #164', status: 'Warning'),
    HistoryArea(area: 'Bukit Aman', place: 'Node #290', status: 'Alert'),
    HistoryArea(area: 'Jalan Damai', place: 'Node #201', status: 'Normal'),
    HistoryArea(area: 'Kampung Baru', place: 'Node #102', status: 'Normal'),
    HistoryArea(area: 'Desa Jaya', place: 'Node #188', status: 'Refuge'),
    HistoryArea(area: 'Bandar Utama', place: 'Node #199', status: 'Normal'),
    HistoryArea(area: 'Sri Hartamas', place: 'Node #211', status: 'Warning'),
  ];
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _areas.where((a) =>
      a.area.toLowerCase().contains(_search.toLowerCase()) ||
      a.place.toLowerCase().contains(_search.toLowerCase())
    ).toList();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 246, 246),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search area or node...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: GoogleFonts.inter(fontSize: 16),
                onChanged: (v) => setState(() => _search = v),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: filtered.length,
                separatorBuilder: (context, i) => Divider(height: 24, color: Colors.grey[300]),
                itemBuilder: (context, i) {
                  final area = filtered[i];
                  return ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/historydetail',
                      arguments: area,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    tileColor: Colors.white,
                    leading: Icon(Icons.location_on, color: Colors.purple, size: 32),
                    title: Text(area.area, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text(area.place, style: GoogleFonts.inter(fontSize: 15, color: Colors.grey[700])),
                    trailing: _StatusChip(status: area.status),
                  );
                },
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
