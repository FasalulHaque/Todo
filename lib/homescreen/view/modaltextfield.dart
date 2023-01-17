import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class ModalTextFiield extends StatelessWidget {
  ModalTextFiield({
    super.key,
    required this.buttonType,
    this.name = '',
    this.descriptlon = '',
    this.toid,
  });

  late TextEditingController descriptionController =
      TextEditingController(text: descriptlon);

  bool buttonType;
  String? name;
  late TextEditingController nameController =
      TextEditingController(text: name ??= '');
  String? descriptlon;
  String? toid;
  final todoRef = FirebaseFirestore.instance.collection('todo collection');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Text(
                // ignore: unnecessary_parenthesis
                (buttonType) ? 'Add todo' : 'Edit todo',
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: nameController,
                // ignore: lines_longer_than_80_chars
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: 'Enter Todo here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: 'Enter Todo descriptlon....',
                  // ignore: lines_longer_than_80_chars
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 360,
                child: ElevatedButton(
                  onPressed: () {
                    if (buttonType) {
                      createTodo(
                        name: nameController.text,
                        description: descriptionController.text,
                      );
                      Navigator.pop(context);
                    } else {
                      updateTodo(
                        todoName: nameController.text,
                        description: descriptionController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    // ignore: unnecessary_parenthesis
                    (buttonType) ? 'Add' : 'Edit',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTodo({
    required String name,
    required String description,
  }) async {
    final auth = FirebaseAuth.instance;
    final userid = auth.currentUser!.uid;

    var uuid = Uuid();

    var todoId = uuid.v4();
    final datetime = DateTime.now();
    final time = '${datetime.hour}:${datetime.minute}pm';
    //print('tamds');
    try {
      await todoRef.doc(todoId).set({
        'todo name': name,
        'description': description,
        'user id': userid,
        'todo id': todoId,
        'date': time,
      });
    } catch (e) {}
  }

  Future<void> updateTodo({
    required String todoName,
    required String description,
  }) async {
    try {
      await todoRef.doc(toid).update({
        'todo name': todoName,
        'description': description,
      });
    } catch (e) {
      rethrow;
    }
  }
}
