import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LegendItem(color: Colors.red, text: 'Maximum'),
          SizedBox(width: 16),
          LegendItem(color: Colors.teal, text: 'Temperatures'),
          SizedBox(width: 16),
          LegendItem(color: Colors.blue, text: 'Minimum'),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}