import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';

class NoticesPage extends StatefulWidget {
  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  // Sample data for notices/announcements
  final List<Notice> _notices = [
    Notice(
      id: 1,
      title: 'Reunião de Pais e Mestres',
      content: 'Convidamos todos os pais e responsáveis para a reunião semestral que acontecerá no dia 20 de Abril às 19h. Sua presença é muito importante!',
      date: DateTime(2025, 4, 15),
      author: 'Diretora Ana Paula',
      imageUrl: null,
    ),
    Notice(
      id: 2,
      title: 'Cardápio da Semana',
      content: 'O cardápio para a próxima semana já está disponível. Inclui opções nutritivas e variadas para as crianças, elaboradas pela nossa nutricionista.',
      date: DateTime(2025, 4, 12),
      author: 'Nutricionista Carla',
      imageUrl: null,
    ),
    Notice(
      id: 3,
      title: 'Campanha de Vacinação',
      content: 'Lembramos que a campanha de vacinação contra a gripe está acontecendo em todas as unidades de saúde do município. É importante manter a carteira de vacinação das crianças em dia.',
      date: DateTime(2025, 4, 8),
      author: 'Enfermeira Juliana',
      imageUrl: null,
    ),
  ];
  
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final isFuncionario = authService.userType == 'funcionario';
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Avisos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshNotices,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _notices.isEmpty
              ? _buildEmptyState()
              : _buildNoticesList(),
      floatingActionButton: isFuncionario
          ? FloatingActionButton(
              onPressed: () => _showAddNoticeDialog(context),
              child: Icon(Icons.add),
            )
          : null,
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Nenhum aviso disponível',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNoticesList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _notices.length,
      itemBuilder: (context, index) {
        final notice = _notices[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notice.imageUrl != null)
                Image.network(
                  notice.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(Icons.error, color: Colors.white),
                      ),
                    );
                  },
                ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(notice.content),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Por: ${notice.author}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(notice.date),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Provider.of<AuthService>(context).userType == 'funcionario'
                            ? TextButton(
                                onPressed: () => _showEditNoticeDialog(context, notice),
                                child: Text('Editar'),
                              )
                            : Container(),
                        Provider.of<AuthService>(context).userType == 'funcionario'
                            ? TextButton(
                                onPressed: () => _deleteNotice(notice.id),
                                child: Text('Excluir', style: TextStyle(color: Colors.red)),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _refreshNotices() {
    setState(() {
      _isLoading = true;
    });
    
    // Simulating API call
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
  
  void _deleteNotice(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir este aviso?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notices.removeWhere((notice) => notice.id == id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Aviso excluído com sucesso')),
              );
            },
            child: Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  
  void _showAddNoticeDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final authorController = TextEditingController(
      text: 'Funcionário(a) ${Provider.of<AuthService>(context, listen: false).userType}',
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Aviso'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16),
              TextField(
                controller: authorController,
                decoration: InputDecoration(
                  labelText: 'Autor',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                setState(() {
                  _notices.add(
                    Notice(
                      id: _notices.isNotEmpty ? _notices.map((n) => n.id).reduce((a, b) => a > b ? a : b) + 1 : 1,
                      title: titleController.text,
                      content: contentController.text,
                      date: DateTime.now(),
                      author: authorController.text,
                      imageUrl: null,
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Aviso adicionado com sucesso')),
                );
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
  
  void _showEditNoticeDialog(BuildContext context, Notice notice) {
    final titleController = TextEditingController(text: notice.title);
    final contentController = TextEditingController(text: notice.content);
    final authorController = TextEditingController(text: notice.author);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Aviso'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16),
              TextField(
                controller: authorController,
                decoration: InputDecoration(
                  labelText: 'Autor',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                setState(() {
                  final index = _notices.indexWhere((n) => n.id == notice.id);
                  if (index != -1) {
                    _notices[index] = Notice(
                      id: notice.id,
                      title: titleController.text,
                      content: contentController.text,
                      date: notice.date,
                      author: authorController.text,
                      imageUrl: notice.imageUrl,
                    );
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Aviso atualizado com sucesso')),
                );
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

class Notice {
  final int id;
  final String title;
  final String content;
  final DateTime date;
  final String author;
  final String? imageUrl;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
    required this.imageUrl,
  });
}
