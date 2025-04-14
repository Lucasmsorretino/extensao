import 'package:flutter/material.dart';

class NoticesPage extends StatelessWidget {
  final List<Map<String, String>> notices = [
    {
      'title': 'Reunião de Pais',
      'content': 'Reunião com os pais na sexta-feira às 18h.',
      'priority': 'Importante'
    },
    {
      'title': 'Festa Junina',
      'content': 'Tragam os alunos vestidos a caráter.',
      'priority': 'Normal'
    },
    {
      'title': 'Alerta de Saúde',
      'content': 'Caso de piolho identificado. Verifiquem as crianças.',
      'priority': 'Urgente'
    },
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Urgente':
        return Colors.red[100]!;
      case 'Importante':
        return Colors.yellow[100]!;
      default:
        return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: notices.length,
      itemBuilder: (context, index) {
        final notice = notices[index];
        return Card(
          color: _getPriorityColor(notice['priority']!),
          child: ListTile(
            title: Text(notice['title']!),
            subtitle: Text(notice['content']!),
            trailing: Text(notice['priority']!, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
