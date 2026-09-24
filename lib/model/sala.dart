
class Sala {
   final int? id;
   final String nome;
   final int capacidade;
   final bool disponivel;

   Sala({this.id, required this.nome, 
         required this.capacidade, this.disponivel =true});
  
    Map<String, dynamic> toMap(){
      return { 
              'id' : this.id,
               'nome' : this.nome,
               'capacidade' : this.capacidade,
               'disponivel' : this.disponivel ? 1 : 0
              };
    }
   
    factory Sala.fromMap( Map<String, dynamic> dados ){
      return Sala( 
                 id: dados['id'],
                 nome: dados['nome'],
                 capacidade: dados['capacidade'],
                 disponivel: dados['disponivel'] == 1 
                );
    }
    

}