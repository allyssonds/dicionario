class Palavra {
  int id;
  String nome;
  String significado;

  Palavra({this.id, this.nome, this.significado});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'significado': significado,
    };
  }
  
}
