import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'splash.dart';
import 'EmergencyPlaceScreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm SOS',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to call SOS?',
            style: GoogleFonts.inter()),
        actions: [
          TextButton(
            child: Text('No', style: GoogleFonts.inter()),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Yes',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyCallScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AegisX',
            style:
                GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 28)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/riskDetail'),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: Colors.red.withOpacity(0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.black54),
                          const SizedBox(width: 10, height: 40),
                          Text('BUKIT JALIL',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('Current Risk Level',
                          style: GoogleFonts.inter(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('HIGH',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  fontSize: 32,
                                  letterSpacing: 1)),
                          const SizedBox(width: 10),
                          Expanded(child: Container()),
                          Icon(Icons.warning_amber_rounded,
                              color: Colors.red[400], size: 40),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleButton(
                    icon: Icons.chat,
                    label: 'Chat with AI',
                    color: Colors.blue[100]!,
                    iconColor: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/chatbot'),
                  ),
                  _CircleButton(
                    icon: Icons.bar_chart,
                    label: 'Historical Data',
                    color: Colors.purple[100]!,
                    iconColor: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/history'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _showSOSDialog(context),
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text('SOS',
                            style: GoogleFonts.inter(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Help Now!',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleButton(
                    icon: Icons.location_on,
                    label: 'Nearby Alerts',
                    color: Colors.green[100]!,
                    iconColor: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/nearby'),
                  ),
                  _CircleButton(
                    icon: Icons.warning,
                    label: 'Live Alerts',
                    color: Colors.yellow[100]!,
                    iconColor: Colors.amber,
                    onTap: () => Navigator.pushNamed(context, '/live'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;
  const _CircleButton(
      {required this.icon,
      required this.label,
      required this.color,
      required this.iconColor,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 48, color: iconColor),
          ),
        ),
        const SizedBox(height: 12),
        Text(label,
            style:
                GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 17)),
      ],
    );
  }
}

class EmergencyCallScreen extends StatefulWidget {
  const EmergencyCallScreen({super.key});

  @override
  State<EmergencyCallScreen> createState() => _EmergencyCallScreenState();
}

class _EmergencyCallScreenState extends State<EmergencyCallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _location = "Getting location...";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    // Simulate location detection
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _location = "Bukit Jalil, Kuala Lumpur";
      });

      // Vibrate the phone
      HapticFeedback.heavyImpact();
      Future.delayed(Duration(milliseconds: 500), () {
        HapticFeedback.heavyImpact();
      });

      // After a short delay, navigate to EmergencyPlaceScreen
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EmergencyPlaceScreen()),
              );
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Emergency Call",
            style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Hello, Barry",
                        style: GoogleFonts.inter(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.red),
                          SizedBox(width: 4),
                          Text(_location,
                              style: GoogleFonts.inter(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Emergency Help Needed?",
                    style: GoogleFonts.inter(
                        fontSize: 26, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Container(
                            width: 220 + (_controller.value * 20),
                            height: 220 + (_controller.value * 20),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text("Connecting to emergency services...",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Please wait while we connect your call",
                      style: GoogleFonts.inter(color: Colors.grey)),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Text("Not Sure What To Do",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text("Choose chat topic",
                    style: GoogleFonts.inter(color: Colors.grey, fontSize: 14)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _EmergencyOption(title: "I have an accident"),
                    _EmergencyOption(title: "I have an injury"),
                    _EmergencyOption(title: "I'm not feeling well"),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyOption extends StatelessWidget {
  final String title;

  const _EmergencyOption({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
