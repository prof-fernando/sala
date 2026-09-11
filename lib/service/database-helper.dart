
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
   
    DatabaseHelper._();
   
    static final  instance = DatabaseHelper._();
    Database? _db;

   // pega o banco de dados
   Future<Database> get database async {
    _db ??= await  _initDB();
    return _db!;
   }

  Future<Database> _initDB() async {
   final url =  join( await getDatabasesPath(), 'meu_banco.xyz' );
   return openDatabase(url, version: 1,
      onCreate: ( bd, versao  ) => bd.execute('''
         create table sala (
             id integer primary key autoincrement,
             nome text not null,
             capacidade integer not null,
             disponivel integer default 1
         );           
      ''')
    );
  }   
}