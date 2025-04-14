import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  final List<Map<String, String>> events = [
    {
      'date': '2025-04-20',
      'title': 'Reunião de Pais',
      'description': 'Reunião com os pais às 18h.'
    },
    {
      'date': '2025-04-25',
      'title': 'Festa da Família',
      'description': 'Evento comemorativo com atividades e lanche.'
    },
    {
      'date': '2025-04-30',
      'title': 'Feriado Municipal',
      'description': 'Escola fechada durante todo o dia.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.event, color: Colors.blue),
            title: Text(event['title']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event['description']!),
                SizedBox(height: 4),
                Text('Data: ${event['date']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        );
      },
    );
  }
}
