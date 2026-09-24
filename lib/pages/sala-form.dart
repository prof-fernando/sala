 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sala_app/model/sala.dart';
import 'package:sala_app/service/sala-service.dart';

class SalaForm extends StatefulWidget {
  const SalaForm({super.key});

  @override
  State<SalaForm> createState() => _SalaFormState();
}

class _SalaFormState extends State<SalaForm> {
  final _form = GlobalKey<FormState>();
  final _txtNome = TextEditingController();
  final _txtCap = TextEditingController();
  bool _disponivel = true;

  final _service = SalaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sala'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
           key: _form,
           child: Column(
             children: [
              TextFormField(
                controller: _txtNome,
                decoration: InputDecoration( 
                  label: Text('Nome:')
                   ),
              validator: (valor) {
                if( valor == null  || valor.trim().isEmpty ){
                  return 'Campo obrigatório';
                }
                return null;
              }  ,     
              ),

              SizedBox(height: 20.0,),
              TextFormField(
                controller: _txtCap,
                keyboardType: TextInputType.number,
               
                decoration: InputDecoration( 
                  label: Text('Capacidade:')
                   ),
              validator: (valor) {
                final capacidade = int.tryParse(valor ?? '');

                if( capacidade == null  || capacidade < 1  ){
                  return 'Digite um número válido';
                }
                return null;
              }  ,     
              ),
              SizedBox(height: 20.0,),
              SwitchListTile(
                value: _disponivel ,
                onChanged: (entrada) => { 

                  setState(() {
                    _disponivel = entrada;
                  })


                  }  
              ),

              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: (){
                 if ( _form.currentState!.validate()) {
                  Sala s = Sala( nome:   _txtNome.value.text,
                    capacidade :  int.parse( _txtCap.value.text ),
                    disponivel : _disponivel
                   );

                  _service.gravar(s );
                  
                 }
              } , child: Text('Salvar') )
             ],
          ), 
        ),
      ),
    );
  }
}