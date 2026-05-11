import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const FormSection({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
