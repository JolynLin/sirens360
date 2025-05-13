import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EmergencyPlaceScreen extends StatefulWidget {
  const EmergencyPlaceScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyPlaceScreen> createState() => _EmergencyPlaceScreenState();
}

class _EmergencyPlaceScreenState extends State<EmergencyPlaceScreen> {
  // Mock coordinates - replace with real coordinates in production
  final LatLng _currentLocation = LatLng(3.1390, 101.6869); // Kuala Lumpur
  final LatLng _responderLocation = LatLng(3.1420, 101.6819); // Nearby location
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Emergency Response',
            style: GoogleFonts.inter(
                color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Arrival Time and Distance Info
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.red.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated Arrival',
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.red, size: 20),
                        SizedBox(width: 4),
                        Text(
                          '8-10 minutes',
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Distance',
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.directions_car, color: Colors.red, size: 20),
                        SizedBox(width: 4),
                        Text(
                          '2.5 km',
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Route Information
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Response Team Route',
                  style: GoogleFonts.inter(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Emergency medical team is on the way to your location. Stay calm and follow the instructions below.',
                  style:
                      GoogleFonts.inter(color: Colors.grey[600], fontSize: 15),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                // Map
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: _currentLocation,
                        zoom: 15,
                        onMapReady: () {
                          // Fit bounds to show both markers
                          _mapController.fitBounds(
                            LatLngBounds(_currentLocation, _responderLocation),
                            options: const FitBoundsOptions(
                              padding: EdgeInsets.all(50.0),
                            ),
                          );
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        // Route line
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: [
                                _currentLocation,
                                _responderLocation,
                              ],
                              color: Colors.blue,
                              strokeWidth: 4,
                            ),
                          ],
                        ),
                        // Current location marker
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentLocation,
                              width: 80,
                              height: 80,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Text('Your Location',
                                        style: GoogleFonts.inter(fontSize: 12)),
                                  ),
                                  SizedBox(height: 8),
                                  Icon(Icons.location_on,
                                      color: Colors.red, size: 28),
                                ],
                              ),
                            ),
                            // Responder location marker
                            Marker(
                              point: _responderLocation,
                              width: 80,
                              height: 80,
                              child: Column(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.blue, size: 28),
                                  SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Text('Response Team',
                                        style: GoogleFonts.inter(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Responder Card
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                  'https://randomuser.me/api/portraits/women/44.jpg'),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dr. Sarah Johnson',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  SizedBox(height: 4),
                                  Text('Emergency Medical Team',
                                      style: GoogleFonts.inter(
                                          color: Colors.grey[600],
                                          fontSize: 13)),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      SizedBox(width: 4),
                                      Text('4.9',
                                          style: GoogleFonts.inter(
                                              color: Colors.grey[800],
                                              fontSize: 13)),
                                      SizedBox(width: 8),
                                      Icon(Icons.directions_car,
                                          color: Colors.grey[600], size: 16),
                                      SizedBox(width: 4),
                                      Text('Toyota Ambulance',
                                          style: GoogleFonts.inter(
                                              color: Colors.grey[600],
                                              fontSize: 13)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.phone, color: Colors.white),
                                label: Text('CALL',
                                    style:
                                        GoogleFonts.inter(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.message, color: Colors.red),
                                label: Text('MESSAGE',
                                    style:
                                        GoogleFonts.inter(color: Colors.red)),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
