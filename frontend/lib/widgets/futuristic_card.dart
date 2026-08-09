import 'package:flutter/material.dart';

class FuturisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const FuturisticCard({
    super.key,

    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        gradient: const LinearGradient(
          colors: [Color(0xff141E30), Color(0xff243B55)],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),

            blurRadius: 15,

            spreadRadius: 2,
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            height: 60,

            width: 60,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: Colors.cyanAccent, size: 32),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 8),

              Text(
                value,

                style: const TextStyle(
                  color: Colors.white,

                  fontSize: 28,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
