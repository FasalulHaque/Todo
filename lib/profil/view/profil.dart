import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/shared_prefirepo/shared_prefirepo.dart';

class Profil extends StatelessWidget {
  Profil({super.key});

  final users = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(
            left: 100,
          ),
          child: Text(
            'Profil',
          ),
        ),
        backgroundColor: const Color.fromARGB(
          255,
          128,
          200,
          132,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            StreamBuilder(
              stream: users.doc(auth.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // ignore: prefer_final_locals
                  var userData = snapshot.data!;
                  // ignore: avoid_print
                  print(userData['email'].toString());
                  // ignore: avoid_print
                  print(userData['userName'].toString());
                  return Column(
                    children: [
                      const Text(
                        'My Account',
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 115,
                        width: 115,
                        child: CircleAvatar(
                          radius: 60,
                          //backgroundImage: NetworkImage('url'),
                          backgroundColor: Colors.white,
                          child: (userData['profileImage'] == '')
                              ? Text(
                                  // ignore: avoid_dynamic_calls
                                  userData['userName'][0]
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 80,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    userData['profileImage'].toString(),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                        ),
                      ),
                      TextButton(
                        onPressed: getImage,
                        child: const Text(
                          'Upload Photo',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        userData['userName'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Text(
                        userData['email'].toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 170, 168, 168),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              title: const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  'My Task',
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 170, 168, 168),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text('Task Done'),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 170, 168, 168),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text('Pending Task'),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 170, 168, 168),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text('Address'),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 170, 168, 168),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text('Notifcation'),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: ListTile(
                                  tileColor: const Color.fromRGBO(
                                    170,
                                    168,
                                    168,
                                    1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text('About Us'),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 330,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                //print(
                                //    '------------------------',);
                                SharedPerf().getUserData();
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _imagePicker = ImagePicker();

    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      await updateProfile(image!);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> updateProfile(XFile image) async {
    final reference =
        FirebaseStorage.instance.ref().child('ProfileImage').child(image.name);
    final file = File(image.path);
    await reference.putFile(file);
    final imageLink = await reference.getDownloadURL();

    await users.doc(auth.currentUser!.uid).update({'profileImage': imageLink});
    // ignore: avoid_print
    print(imageLink);
  }
}
