// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, prefer_const_constructors

import 'package:course_organizer/Controller/Controladora.dart';
import 'package:course_organizer/View/AdminFunctions.dart';
import 'package:course_organizer/View/StudentFunctions.dart';
import 'package:course_organizer/View/TeacherFunctions.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Login> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {
  String email = '', password = '';

  Future<void> _login() async {
    var control = Controladora();
    if (await control.login(email, password)) {
      if(await control.getRole(email) == "Estudiante"){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentFunctions(
              title: 'Funciones',
            )
          ),
        );
      } else if (await control.getRole(email) == "Docente") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherFunctions(
              title: 'Funciones',
            )
          ),
        );
      } else if (await control.getRole(email) == "Administrador"){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminFunctions(
              title: 'Funciones',
            )
          ),
        );
      }
    } else {
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Iniciar Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                )),
            TextField(
              onChanged: (text) {
                email = text;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo',
              ),
            ),
            TextField(
              onChanged: (text) {
                password = text;
              },
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _login,
        tooltip: 'Increment',
        child: const Icon(Icons.login),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Usuario o contraseña incorrectos."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
