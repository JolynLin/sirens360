import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash.dart';

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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('SOS called!', style: GoogleFonts.inter())),
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
        title: Text('SIRENS 360',
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
