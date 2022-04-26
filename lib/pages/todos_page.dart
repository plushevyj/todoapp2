import 'package:flutter/material.dart';
import 'package:todoapp/service/api_provider.dart';
import 'package:intl/intl.dart';

ApiProvider provider = ApiProvider();

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {

  void addNewTask({required String task}) {
    provider.postTask(date: DateFormat('dd.MM.yyyy').format(DateTime.now()).toString(), task: task);
    setState(() {
      // provider.getTasks();
    });
  }

  void deleteTask({required String indexTask}) {
    provider.deleteTask(index: indexTask);
  }

  @override
  Widget build(BuildContext context) {
    String textInput = '';
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить новую задачу',
        // backgroundColor: Colors.blue,
        child: const Icon(Icons.note_add_outlined, color: Colors.white,),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Добавить задачу'),
              content: TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: 'Введите текст',
                  border: UnderlineInputBorder(),
                ),
                onChanged: (String value) {
                  textInput = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      textInput = "";
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Text('ОТМЕНА')),
                TextButton(
                    onPressed: () {
                      if (textInput != "") addNewTask(task: textInput);
                      print(textInput);
                      textInput = "";
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Text('ОК')
                ),
              ],
            );
          });
        },
      ),
      body: Center(
        child: FutureBuilder(
          future: provider.getTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.connectionState == ConnectionState.none) {
              return const Center(child: Text('Data not found'));
            }
            else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              var tasks = snapshot.data as Map<String, dynamic>;
              return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    String key = tasks.keys.elementAt(index);
                    return Dismissible(
                      onDismissed: (_) => deleteTask(indexTask: key),
                      key: Key(index.toString()),
                      child: Card(
                        child: ListTile(
                          title: Text(tasks[key]['task']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.grey,
                            onPressed: () => deleteTask(indexTask: key),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        color: Colors.white70,

                      ),
                    );
                  }
              );
            }
            else {
              return const Center(child: Text('Default'));
            }
          },
        ),
      ),
    );
  }
}