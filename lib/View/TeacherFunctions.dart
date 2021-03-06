// ignore_for_file: file_names

import 'package:course_organizer/Controller/Controladora.dart';
import 'package:course_organizer/View/TeacherCourseView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeacherFunctions extends StatefulWidget {
  const TeacherFunctions({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TeacherFunctions> createState() => _TeacherFunctionsPage();
}

class _TeacherFunctionsPage extends State<TeacherFunctions> {
  var control = Controladora();
  String cedula = "";

  Future<List<String>> _getCursosProfesor(String cedula) async {
    return await control.getNombresCursosProfesor(cedula);
  }

  Future<String> _getCedula(String email) async {
    return await control.getCedulaUsuario(email);
  }

  Future<List<String>> _getCursosUsuario(String email) async {
    var cedula = await _getCedula(email);
    return _getCursosProfesor(cedula);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
        future: _getCursosUsuario(widget.title.split(" ")[2]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherCourseView(
                            title:
                              'Curso ${snapshot.data[index]}',
                          )
                        )
                      );
                    }
                  )
                );
              }
            );
          } else if (snapshot.hasError) {
            return const Text('No se encontraron datos');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
