import 'package:flutter/material.dart';

class EmptyImageGen extends StatelessWidget {
  const EmptyImageGen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Generate stunning images with AI',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Type a prompt to create your first image',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
