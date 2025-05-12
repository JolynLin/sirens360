import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double gasLevel = 100;
  double tempLevel = 35;
  double waterLevel = 25;
  bool pushNotif = true;
  bool emailNotif = true;
  bool smsNotif = false;
  bool soundNotif = true;
  String language = 'English (US)';
  final List<String> languages = ['English (US)', 'Bahasa Malaysia', '中文', 'தமிழ்'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          children: [
            // Alert Thresholds Section
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alert Thresholds', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 4),
                  Text('Set risk thresholds for receiving notifications', style: GoogleFonts.inter(fontSize: 15, color: Colors.black54)),
                  const SizedBox(height: 18),
                  _SliderTile(
                    label: 'Gas Level (ppm)',
                    value: gasLevel,
                    min: 0,
                    max: 400,
                    onChanged: (v) => setState(() => gasLevel = v),
                  ),
                  _SliderTile(
                    label: 'Temperature (°C)',
                    value: tempLevel,
                    min: 0,
                    max: 60,
                    onChanged: (v) => setState(() => tempLevel = v),
                  ),
                  _SliderTile(
                    label: 'Water Level (cm)',
                    value: waterLevel,
                    min: 0,
                    
                    max: 100,
                    onChanged: (v) => setState(() => waterLevel = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            // Notification Preferences Section
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notification Preferences', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  _SwitchTile(
                    label: 'Push Notifications',
                    value: pushNotif,
                    onChanged: (v) => setState(() => pushNotif = v),
                  ),
                  Divider(height: 18, color: Colors.grey[200]),
                  _SwitchTile(
                    label: 'Email Alerts',
                    value: emailNotif,
                    onChanged: (v) => setState(() => emailNotif = v),
                  ),
                  Divider(height: 18, color: Colors.grey[200]),
                  _SwitchTile(
                    label: 'SMS Alerts',
                    value: smsNotif,
                    onChanged: (v) => setState(() => smsNotif = v),
                  ),
                  Divider(height: 18, color: Colors.grey[200]),
                  _SwitchTile(
                    label: 'Sound Alerts',
                    value: soundNotif,
                    onChanged: (v) => setState(() => soundNotif = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            // Language Section
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Language', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: language,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                        items: languages.map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang, style: GoogleFonts.inter()),
                        )).toList(),
                        onChanged: (v) => setState(() => language = v ?? language),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Language selection is UI-only. Full multilingual support requires app localization.',
                          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/home'),
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.home, color: Colors.white),
        label: Text('Home', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  const _SliderTile({required this.label, required this.value, required this.min, required this.max, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 15)),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            label: value.toStringAsFixed(0),
            onChanged: onChanged,
            activeColor: Colors.blue,
            inactiveColor: Colors.blue[100],
          ),
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile({required this.label, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 16)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
      child: child,
    );
  }
}
