 
 import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sala_app/pages/sala-form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sala APP'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder:  (context) => SalaForm() )
            );
          } ),
      
    ) ;
  }
}