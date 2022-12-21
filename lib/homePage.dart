
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key, required String home}) : super(key: key);

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  List todos = <dynamic>[];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  //READ
  fetchData() async {
    var response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    setState(() {
      todos = convert.jsonDecode(response.body);
    });
  }

  //DELETE
  deleteData(var todo) async {
    var response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo['id']}'));

    if (response.statusCode == 200) {
      showSuccessMessage('Deleted Successfully');
      setState(() {
        todos.remove(todo);
      });
    } else {
      showErrorMessage('Request failed with a status: ${response.statusCode}');
      throw Exception('Failed to delete todo');
    }
  }

  displayEditedData(var object) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(
            'Successfully edited Title: ${object["title"]} ID: ${object["id"]}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const Icon(Icons.list_alt_rounded),
            title: const Text('Todo List')),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                ),
                key: UniqueKey(),
                child: ListTile(
                    title: Text(todos.toString()),
                ),
                  onDismissed: (direction){
                  setState(() {
                    deleteData(todo['id']);
                  });
                  },
              );
            }),
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
