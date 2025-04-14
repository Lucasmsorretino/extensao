import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  final List<Map<String, String>> healthRecords = [
    {
      'type': 'Medicação',
      'date': '2025-04-13',
      'description': 'Paracetamol 200mg administrado às 14h.'
    },
    {
      'type': 'Observação',
      'date': '2025-04-11',
      'description': 'Criança apresentou leve alergia na pele. Monitorar.'
    },
    {
      'type': 'Doença',
      'date': '2025-04-09',
      'description': 'Resfriado com leve febre, enviado recado aos responsáveis.'
    },
  ];

  IconData _getIcon(String type) {
    switch (type) {
      case 'Medicação':
        return Icons.medication;
      case 'Observação':
        return Icons.visibility;
      case 'Doença':
        return Icons.sick;
      case 'Alergia':
        return Icons.warning;
      default:
        return Icons.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: healthRecords.length,
      itemBuilder: (context, index) {
        final record = healthRecords[index];
        return Card(
          child: ListTile(
            leading: Icon(_getIcon(record['type']!), color: Colors.teal),
            title: Text(record['type']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record['description']!),
                SizedBox(height: 4),
                Text('Data: ${record['date']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        );
      },
    );
  }
}