import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


var arrayresult = [];
var vartemp = "";
void main() {
  runApp(MyMemoryGame());
  
}

class Apiclient {
  final String apiUrl = 'https://kictzalsajqllcsaukde.supabase.co/rest/v1/tareaflutter';
  Future<void> postScore(int puntos, String fecha) async {
    final Uri uri = Uri.parse(apiUrl);
    
    // Cabeceras POST
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpY3R6YWxzYWpxbGxjc2F1a2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjEwNDUsImV4cCI6MjAxODYzNzA0NX0.BKUH4osg-EF8IShXKytAu2Ej2WTNf4mRWGrxG8pksU0',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpY3R6YWxzYWpxbGxjc2F1a2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjEwNDUsImV4cCI6MjAxODYzNzA0NX0.BKUH4osg-EF8IShXKytAu2Ej2WTNf4mRWGrxG8pksU0',
    };
    
    // Cuerpo  POST
    final Map<String, dynamic> body = {
      'puntuación': puntos,
      'fecha': fecha,
    };

    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    print('Respuesta POST: ${response.statusCode}');
  }
  // Método para hacer una petición GET y obtener datos de la base de datos
  Future<List<Map<String, dynamic>>> getScores() async {
    final Uri uri = Uri.parse('$apiUrl?select=*');
    
    // Cabeceras de la petición GET
    final Map<String, String> headers = {
      'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpY3R6YWxzYWpxbGxjc2F1a2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjEwNDUsImV4cCI6MjAxODYzNzA0NX0.BKUH4osg-EF8IShXKytAu2Ej2WTNf4mRWGrxG8pksU0',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpY3R6YWxzYWpxbGxjc2F1a2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjEwNDUsImV4cCI6MjAxODYzNzA0NX0.BKUH4osg-EF8IShXKytAu2Ej2WTNf4mRWGrxG8pksU0', 
    };

    final http.Response response = await http.get(
      uri,
      headers: headers,
    );

 
    print('Respuesta GET: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {

      return [];
    }
  }
  Future<void> printAllScores() async {
    final Uri uri = Uri.parse('$apiUrl?select=*');
    final Map<String, String> headers = {
      'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpY3R6YWxzYWpxbGxjc2F1a2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjEwNDUsImV4cCI6MjAxODYzNzA0NX0.BKUH4osg-EF8IShXKytAu2Ej2WTNf4mRWGrxG8pksU0', 
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpY3R6YWxzYWpxbGxjc2F1a2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjEwNDUsImV4cCI6MjAxODYzNzA0NX0.BKUH4osg-EF8IShXKytAu2Ej2WTNf4mRWGrxG8pksU0',
    };

    final http.Response response = await http.get(
      uri,
      headers: headers,
    );

    print('Respuesta GET: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      for (var record in data) {
        arrayresult.add(record);
        print(record);
      }
    } else {
      print('Error al obtener los datos.');
    }
  }
}
class MyMemoryGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyMemoryGamePage(),
    );
  }
}

class MyMemoryGamePage extends StatefulWidget {
  @override
  _MyMemoryGamePageState createState() => _MyMemoryGamePageState();
}

class _MyMemoryGamePageState extends State<MyMemoryGamePage> {
  

  TextEditingController textEditingController1 = TextEditingController();
  bool showImages = true;
  bool showPuntuation = true;
  String Titulo1 = 'Bienvenido a tu juego de memoria de coches\n Acuerdate del ordenes de estas imagenes...';
  String Titulo2 = 'Se han acabado las oportunidades';
  String HoraFinal = "";
  int contador = 0;
  int contadorpulsado = 0;
  int puntuation= 0;
  var Hora;
  var correctlist = [1,2,3,4];
  var userlist = [];

void bucle(){

  var y = arrayresult.length-5;
  for(var x  = y; x < arrayresult.length; x++){
    vartemp = vartemp+ arrayresult[x].toString()+'\n';
  }
}
void Calculation(){
  puntuation = 0;
  if(userlist.length >3)
    for(var i = 0; i < 4; i++){
    if (correctlist[i] == userlist [i])
      puntuation++;  
    }
  Date();
  if(contadorpulsado == 4 && HoraFinal != "")
    guardar();
}

void Date(){
  Hora = DateTime.now();
  HoraFinal = Hora.toString();
}

void guardar (){
  final Apiclient apiClient = Apiclient();
  apiClient.postScore(puntuation,HoraFinal);
  final Future<List<Map<String, dynamic>>> puntos =  apiClient.getScores();
  apiClient.printAllScores();
}

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Memoria'),
        
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            if(contador == 2)
              Text(
                'Tu puntuacion es: $puntuation \n La fecha de la partida es: $Hora',
                style: TextStyle(fontSize: 50.0),
                ),
            if((contador <2) & (contadorpulsado < 4))
              Text(
                '$Titulo1',
                style: TextStyle(fontSize: 30.0),
                ),
            if((contadorpulsado >= 4) & (contador <2)) 
              Text(
                '$Titulo2',
                style: TextStyle(fontSize: 30.0),
                ), 
            SizedBox(height: 70.0),
            if (showImages & showPuntuation == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset('imagenes/audi.jpg', width: 80.0, height: 80.0),
                SizedBox(width: 30.0),
                Image.asset('imagenes/ferrari.jpg', width: 80.0, height: 80.0),
                SizedBox(width: 30.0),
                Image.asset('imagenes/lambourguini.jpg', width: 80.0, height: 80.0),
                SizedBox(width: 30.0),
                Image.asset('imagenes/porche.jpg', width: 80.0, height: 80.0),
              ],
              
              )
              
            else
            if(showImages==false & (showPuntuation==false))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  if(contadorpulsado < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        userlist.add(2);
                        contadorpulsado++;
                        print(contadorpulsado);
                        print(userlist);
                     }),
                      child: Text('1'),
                    ),
                  SizedBox(width: 70.0),
                  
                  if(contadorpulsado < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        userlist.add(4);
                        contadorpulsado++;
                        print(userlist);
                      }),
                      child: Text('2'),
                    ),
                    SizedBox(width: 70.0),

                  if(contadorpulsado < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        userlist.add(1);
                        contadorpulsado++;
                        print(userlist);
                      }),
                      child: Text('3'),
                    ),
                    SizedBox(width: 70.0),
                  if(contadorpulsado < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        userlist.add(3);
                        contadorpulsado++;
                        print(userlist);
                      }),
                      child: Text('4'), 
                    ),
                  
                ],
              ),
              
            if(contador == 3)
              
              Text(
                  '$vartemp',
                style: TextStyle(fontSize: 50.0),
                ),
            if(contador ==2)
              ElevatedButton(
                      onPressed: () => setState(() {
                        print('Pedro');
                        contador++;
                        bucle();

                      }),
                      child: Text('Guardar'),
                    ),
                    SizedBox(width: 70.0),
            if(contador == 3)
            ElevatedButton(
                      onPressed: () => setState(() {
                        contador = 0;
                        contadorpulsado = 0;
                        showImages = true;
                        showPuntuation = true;
                        Titulo1 = 'Bienvenido a tu juego de memoria de coches\n Acuerdate del ordenes de estas imagenes...';
                      }),
                      child: Text('Guardar'),
                    ),
                    SizedBox(width: 70.0),
            if(showImages==false & (showPuntuation==false))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                Image.asset('imagenes/ferrari.jpg', width: 120.0, height: 80.0),
               
                Image.asset('imagenes/porche.jpg', width: 130.0, height: 80.0),
                SizedBox(height: 120.0),
                
                Image.asset('imagenes/audi.jpg', width: 130.0, height: 80.0),
                
  
                Image.asset('imagenes/lambourguini.jpg', width: 120.0, height: 80.0),
                ]
              ),
            SizedBox(height: 20.0),
            if(contador <2)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Calculation();
                    showImages =  !showImages;
                    showPuntuation = false;
                    Titulo1 = '¿Cual era el orden de las imagenes?';
                    contador ++;
                  });
                },
                child: Text(showImages ? 'Jugar' : 'Continuar'),
              ),
            
            
          ],
        ),
      ),
    );
  }
}