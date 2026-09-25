 
 import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sala_app/model/sala.dart';
import 'package:sala_app/pages/sala-form.dart';
import 'package:sala_app/service/sala-service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Sala>> _salas;
  final SalaService _service = SalaService();

  @override
  void initState() {
    super.initState();
    _salas = _service.buscaTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sala APP'),
        ),
        body: FutureBuilder(future: _salas, builder: (ctx, snap) {
          if( snap.connectionState != ConnectionState.done ){
            return Center( child: CircularProgressIndicator(), );
          }
          final dados = snap.data;
          if(dados == null || dados.isEmpty){
            return Text('Nenhuma sala encontrada!');
          }
          // exitem salas, vamos contruir o componente
          return  ListView.builder(
            itemCount: dados.length,
            itemBuilder: (ctx, i) {
                final sala = dados[i];
                return  ListTile(
                  leading: Icon( 
                        sala.disponivel ? Icons.check : Icons.close

                    ),
                    title: Text(sala.nome),
                    subtitle: Text('Capacidade ${sala.capacidade}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                       children: [
                      
                      IconButton(onPressed: (){

                           Navigator.push(context, 
                          MaterialPageRoute(builder:  (context) => SalaForm( sala:  sala) )
                          ).then( (_){
                              setState(() {
                                 _salas = _service.buscaTodos();
                              });
                           });

                      }, icon: Icon(Icons.edit)),
                      IconButton(onPressed: () async {
                        final result = await _service.deletar(sala.id!);
                        if(result > 0){
                           setState(() {
                                 _salas = _service.buscaTodos();
                              });
                        }

                      }, icon: Icon(Icons.delete))
                    ], )  ,
                ) ;
            }  );
        }  ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder:  (context) => SalaForm() )
            ).then( (_){
                              setState(() {
                                 _salas = _service.buscaTodos();
                              });
                           });
          } ),
      
    ) ;
  }
}