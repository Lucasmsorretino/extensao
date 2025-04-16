class Aviso {
  final int id;
  final String titulo;
  final String mensagem;
  final DateTime dataPublicacao;
  final String? imagemUrl;
  final int autorId;
  
  Aviso({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.dataPublicacao,
    this.imagemUrl,
    required this.autorId,
  });
  
  factory Aviso.fromJson(Map<String, dynamic> json) {
    return Aviso(
      id: json['id'],
      titulo: json['titulo'],
      mensagem: json['mensagem'],
      dataPublicacao: DateTime.parse(json['data_publicacao']),
      imagemUrl: json['imagem_url'],
      autorId: json['autor_id'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'mensagem': mensagem,
      'data_publicacao': dataPublicacao.toIso8601String(),
      'imagem_url': imagemUrl,
      'autor_id': autorId,
    };
  }
}