
import 'package:sala_app/model/sala.dart';
import 'package:sala_app/service/database-helper.dart';

class SalaService {

    Future<int> gravar( Sala s ) async {
      final db = await DatabaseHelper.instance.database;
     return db.insert('sala',  s.toMap() );
    }


}