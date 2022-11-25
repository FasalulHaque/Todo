// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/homescreen/home.dart';
import 'package:todo/profil/view/profil.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  CollectionReference todoRef =
      FirebaseFirestore.instance.collection('todo collection');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                // ignore: inference_failure_on_instance_creation
                MaterialPageRoute(
                  builder: (context) => Profil(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: todoRef
            .where('user id', isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            // ignore: avoid_print
            print(snapshot.data!.docs);
            // ignore: unused_local_variable
            final todoitems = snapshot.data!.docs;

            // ignore: avoid_print
            print(todoitems[2]['todo name']);

            return ListView.builder(
              itemCount: todoitems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todoitems[index]['todo name'].toString()),
                  subtitle: Text(todoitems[index]['description'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => ModalTextFiield(
                              buttonType: false,
                              name: todoitems[index]['todo name'].toString(),
                              descriptlon:
                                  todoitems[index]['description'].toString(),
                              toid: todoitems[index]['todo id'].toString(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteTodo(todoitems[index]['todo id'].toString());
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: inference_failure_on_function_invocation
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ModalTextFiield(
                buttonType: true,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> deleteTodo(String id) async {
    final todoRef = FirebaseFirestore.instance.collection('todo collection');
    try {
      await todoRef.doc(id).delete();
    } catch (e) {}
  }
}
