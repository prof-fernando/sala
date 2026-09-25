
import 'package:sala_app/model/sala.dart';
import 'package:sala_app/service/database-helper.dart';

class SalaService {

    Future<int> gravar( Sala s ) async {
      final db = await DatabaseHelper.instance.database;
      if( s.id != null ){
        return db.update(
          'sala',
          s.toMap(),
          where: 'id = ?',
          whereArgs: [s.id]
           );
      }else{
        return db.insert('sala',  s.toMap() );
      }
    }
     
    Future<List<Sala>> buscaTodos() async {
      final db = await DatabaseHelper.instance.database;
      final dados = await db.query('sala');
      return dados.map(  (itemAtual) => Sala.fromMap(itemAtual)  ).toList();
    } 
    
    Future<int> deletar( int id ) async{
      final db = await DatabaseHelper.instance.database;
     return db.delete('sala', where: 'id = ?', whereArgs: [id]);
    }

   
}