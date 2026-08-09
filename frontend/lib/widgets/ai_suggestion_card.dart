import 'package:flutter/material.dart';

class AISuggestionCard extends StatelessWidget {
  final String text;

  const AISuggestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff121212),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "AI Assistant 🤖",

              style: TextStyle(
                color: Colors.cyanAccent,

                fontSize: 20,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              text,

              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
