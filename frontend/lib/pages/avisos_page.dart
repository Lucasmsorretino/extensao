import 'package:flutter/material.dart';
import '../services/avisos_service.dart';
import '../models/aviso.dart';

class AvisosPage extends StatefulWidget {
  @override
  _AvisosPageState createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> {
  late Future<List<Aviso>> _avisosFuture;
  final _avisosService = AvisosService();
  
  @override
  void initState() {
    super.initState();
    _loadAvisos();
  }
  
  void _loadAvisos() {
    _avisosFuture = _avisosService.getAvisos();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avisos'),
      ),
      body: FutureBuilder<List<Aviso>>(
        future: _avisosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar avisos: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Nenhum aviso disponível'),
            );
          } else {
            final avisos = snapshot.data!;
            return ListView.builder(
              itemCount: avisos.length,
              itemBuilder: (context, index) {
                final aviso = avisos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(aviso.titulo),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(aviso.mensagem),
                        SizedBox(height: 4),
                        Text(
                          'Publicado em: ${_formatDate(aviso.dataPublicacao)}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new announcement (for staff only)
        },
        child: Icon(Icons.add),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}