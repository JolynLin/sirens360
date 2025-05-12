import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

class NearbyAlertsScreen extends StatefulWidget {
  const NearbyAlertsScreen({super.key});

  @override
  State<NearbyAlertsScreen> createState() => _NearbyAlertsScreenState();
}

enum AlertType { all, gas, temperature, water, refuge }

class _AlertPin {
  final String id;
  final LatLng point;
  final Color color;
  final AlertType type;
  final String label;
  final IconData icon;
  const _AlertPin({required this.id, required this.point, required this.color, required this.type, required this.label, required this.icon});
}

class _NearbyAlertsScreenState extends State<NearbyAlertsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Gas', 'Temperature', 'Water', 'Refuge'];
  final List<AlertType> _filterTypes = [
    AlertType.all, AlertType.gas, AlertType.temperature, AlertType.water, AlertType.refuge
  ];
  double _zoom = 13.0;
  final MapController _mapController = MapController();

  // Example pins (mock data)
  final List<_AlertPin> _allPins = [
    _AlertPin(id: 'disaster1', point: LatLng(3.1203, 101.6544), color: Colors.red, type: AlertType.gas, label: 'Taman Indah', icon: Icons.local_fire_department),
    _AlertPin(id: 'safe1', point: LatLng(3.1250, 101.6550), color: Colors.green, type: AlertType.refuge, label: 'Bukit Aman', icon: Icons.safety_divider),
    _AlertPin(id: 'warn1', point: LatLng(3.1220, 101.6500), color: Colors.amber, type: AlertType.temperature, label: 'Jalan Damai', icon: Icons.thermostat),
    _AlertPin(id: 'water1', point: LatLng(3.1240, 101.6520), color: Colors.blue, type: AlertType.water, label: 'Kampung Baru', icon: Icons.water),
    _AlertPin(id: 'gas2', point: LatLng(3.1210, 101.6560), color: Colors.red, type: AlertType.gas, label: 'Taman Maju', icon: Icons.local_fire_department),
    _AlertPin(id: 'refuge2', point: LatLng(3.1260, 101.6530), color: Colors.green, type: AlertType.refuge, label: 'Desa Jaya', icon: Icons.safety_divider),
    _AlertPin(id: 'temp2', point: LatLng(3.1230, 101.6510), color: Colors.amber, type: AlertType.temperature, label: 'Bandar Utama', icon: Icons.thermostat),
    _AlertPin(id: 'water2', point: LatLng(3.1270, 101.6540), color: Colors.blue, type: AlertType.water, label: 'Sri Hartamas', icon: Icons.water),
  ];

  void _onPinTap(String alertId) {
    Navigator.pushNamed(context, '/riskDetail', arguments: alertId);
  }

  void _zoomIn() {
    setState(() {
      _zoom = (_zoom + 1).clamp(10.0, 18.0);
      _mapController.move(_mapController.center, _zoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoom = (_zoom - 1).clamp(10.0, 18.0);
      _mapController.move(_mapController.center, _zoom);
    });
  }

  List<_AlertPin> get _filteredPins {
    if (_filterTypes[_selectedFilter] == AlertType.all) return _allPins;
    return _allPins.where((pin) => pin.type == _filterTypes[_selectedFilter]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Area
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(3.123, 101.653),
              zoom: _zoom,
              minZoom: 10,
              maxZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.umtech_frontend1',
              ),
              MarkerLayer(
                markers: _filteredPins.map((pin) => Marker(
                  point: pin.point,
                 child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) => _PinActionSheet(placeName: pin.label, onDetails: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/riskDetail', arguments: pin.id);
                        }, onForum: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            builder: (context) => _LiveForumSheet(placeName: pin.label),
                          );
                        }),
                      );
                    },
                    child: Icon(Icons.location_pin, color: pin.color, size: 40),
                  ),
                )).toList(),
              ),
            ],
          ),
          // Floating Search Bar
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                style: GoogleFonts.inter(),
                decoration: InputDecoration(
                  hintText: 'Search for locations...',
                  hintStyle: GoogleFonts.inter(),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          // Filter Bar (just below search bar)
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: List.generate(_filters.length, (index) {
                  final isSelected = _selectedFilter == index;
                  final selectedColors = [
                    Colors.blue[700],   // All (selected)
                    Colors.red[700],    // Gas (selected)
                    Colors.amber[800],  // Temperature (selected)
                    Colors.blue[900],   // Water (selected)
                    Colors.green[700],  // Refuge (selected)
                  ];
                  final unselectedColor = const Color.fromARGB(255, 255, 255, 255);
                  final icon = [
                    Icons.layers,
                    Icons.local_fire_department,
                    Icons.thermostat,
                    Icons.water,
                    Icons.safety_divider,
                  ][index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      avatar: Icon(icon, color: isSelected ? Colors.white : Colors.black54, size: 20),
                      label: Text(
                        _filters[index],
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedFilter = index);
                      },
                      selectedColor: selectedColors[index],
                      backgroundColor: unselectedColor,
                      labelStyle: GoogleFonts.inter(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 0,
                    ),
                  );
                }),
              ),
            ),
          ),
          // Zoom controls
          Positioned(
            right: 20, top: 170,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  heroTag: 'zoomIn',
                  backgroundColor: Colors.white,
                  elevation: 4,
                  onPressed: _zoomIn,
                  child: Icon(Icons.add, color: Colors.black),
                ),
                SizedBox(height: 12),
                FloatingActionButton(
                  mini: true,
                  heroTag: 'zoomOut',
                  backgroundColor: Colors.white,
                  elevation: 4,
                  onPressed: _zoomOut,
                  child: Icon(Icons.remove, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
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
          currentIndex: 1, // Map tab
          onTap: (index) {
            if (index == 0) Navigator.pushNamed(context, '/home');
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
              icon: _NavIcon(
                icon: Icons.home,
                color: Colors.pink,
                selected: 1 == 0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(
                icon: Icons.map,
                color: Colors.green,
                selected: 1 == 1,
              ),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(
                icon: Icons.bar_chart,
                color: Colors.purple,
                selected: 1 == 2,
              ),
              label: 'Data',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(
                icon: Icons.warning,
                color: Colors.amber,
                selected: 1 == 3,
              ),
              label: 'Live',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(
                icon: Icons.chat,
                color: Colors.blue,
                selected: 1 == 4,
              ),
              label: 'AI Chatbot',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool selected;
  const _NavIcon({required this.icon, required this.color, required this.selected});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: selected
          ? BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            )
          : null,
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: color, size: 28),
    );
  }
}

class _LiveForumSheet extends StatelessWidget {
  final String placeName;
  const _LiveForumSheet({required this.placeName});
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(placeName, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  _ForumMessage(user: 'Alice', message: 'Is the area safe now?'),
                  _ForumMessage(user: 'Bob', message: 'There is still some smoke.'),
                  _ForumMessage(user: 'Charlie', message: 'Refuge at the school is open.'),
                  _ForumMessage(user: 'Diana', message: 'Water level is rising near the river.'),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: GoogleFonts.inter(),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.blue,
                  onPressed: () {},
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ForumMessage extends StatelessWidget {
  final String user;
  final String message;
  const _ForumMessage({required this.user, required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(user[0]),
            backgroundColor: Colors.blue[100],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(message, style: GoogleFonts.inter(fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PinActionSheet extends StatelessWidget {
  final String placeName;
  final VoidCallback onDetails;
  final VoidCallback onForum;
  const _PinActionSheet({required this.placeName, required this.onDetails, required this.onForum});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(placeName, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.info_outline),
                  label: Text('Details', style: GoogleFonts.inter()),
                  onPressed: onDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.forum),
                  label: Text('Live Forum', style: GoogleFonts.inter()),
                  onPressed: onForum,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
