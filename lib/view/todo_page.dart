import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/todo_list_controller.dart';
import '../model/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<TodoController>();
    final titleEC = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List Page'),
        centerTitle: true,
      ),
      body: Consumer<TodoController>(
        builder: (context, todoList, child) {
          return todoList.getAllTOdos.isEmpty
              ? const Center(
                  child: Text('Lista vazia'),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 1,
                    );
                  },
                  itemCount: todoList.getAllTOdos.length,
                  itemBuilder: (context, index) {
                    Todo todo = todoList.getAllTOdos[index];
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      selected: todo.isDone,
                      title: Text(todo.title),
                      trailing: Checkbox(
                          value: todo.isDone,
                          onChanged: (value) {
                            todoList.changeValue(index);
                          }),
                      onLongPress: () {
                        todoList.removeTodo(todo);
                      },
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: titleEC,
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return 'Titulo deve conter mais de 3 caracteres';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.addTodo(
                                    Todo(title: titleEC.text),
                                  );
                                  titleEC.clear();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Adicionar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.clearAll();
                                titleEC.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Limpar Tudo'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    )),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
