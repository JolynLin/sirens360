import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SIRENS 360',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.account_circle),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDEDED),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.black54),
                    const SizedBox(width: 8),
                    const Text(
                      'BUKIT JALIL',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'Current Risk Level',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        Text(
                          'High',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                      size: 36,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    _HomeButton(
                      icon: Icons.chat_bubble_outline,
                      label: 'Chat with AI',
                      onTap: () {},
                    ),
                    _HomeButton(
                      icon: Icons.bar_chart,
                      label: 'Historical Data',
                      onTap: () {},
                    ),
                    _HomeButton(
                      icon: Icons.sos,
                      label: 'SOS',
                      color: Colors.red,
                      textColor: Colors.white,
                      isLarge: true,
                      onTap: () {},
                    ),
                    _HomeButton(
                      icon: Icons.place,
                      label: 'Nearby Alerts',
                      color: Colors.green[100],
                      iconColor: Colors.green,
                      onTap: () {},
                    ),
                    _HomeButton(
                      icon: Icons.shield,
                      label: 'Live Alerts',
                      color: Colors.yellow[100],
                      iconColor: Colors.amber,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;
  final bool isLarge;

  const _HomeButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.iconColor,
    this.textColor,
    this.isLarge = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: isLarge ? 48 : 36,
                color: iconColor ?? Colors.black54,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.black87,
                  fontSize: isLarge ? 20 : 14,
                ),
                textAlign: TextAlign.center,
              ),
              if (isLarge)
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Help Now!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
