import 'package:flutter/material.dart';

class AlarmCard extends StatelessWidget {
  final String title;
  final String alarmTime;
  final List<Color> gradientColor;
  final Function(bool) onChanged;
  final bool switchValue;
  final VoidCallback onDelete;

  const AlarmCard({
    super.key,
    required this.title,
    required this.alarmTime,
    required this.gradientColor,
    required this.onChanged,
    required this.switchValue,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColor.last.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.label,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'avenir',
                    ),
                  ),
                ],
              ),
              Switch(
                onChanged: onChanged,
                value: switchValue,
                activeColor: Colors.white,
              ),
            ],
          ),
          const Text(
            'Mon-Fri',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'avenir',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                alarmTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'avenir',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.white,
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
