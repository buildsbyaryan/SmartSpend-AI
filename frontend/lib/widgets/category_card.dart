import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;

  const CategoryCard({
    super.key,

    required this.title,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),

        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade900, Colors.black87],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.25),

            blurRadius: 12,

            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            height: 45,

            width: 45,

            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.15),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: Colors.cyanAccent, size: 25),
          ),

          const SizedBox(height: 15),

          Text(
            title,

            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),

          const SizedBox(height: 8),

          Text(
            "\₹${amount.toStringAsFixed(2)}",

            style: const TextStyle(
              color: Colors.white,

              fontSize: 20,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
