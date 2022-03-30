import 'package:capybaflutter/controller/user-c.dart';
import 'package:capybaflutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final userController = Provider.of<UserControl>(context, listen: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final users = snapshot.data!.docs.map((map) {
            final data = map.data();
            return UserInfo.fromMap(data);
          }).toList();
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              if (user.name == userController.model.name) {
                return Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Text(userController.model.name),
                      Text(userController.user!.email!),
                    ],
                  ),
                );
              }
              return Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    Text(user.name),
                    Text(userController.user!.email!),
                  ],
                ),
              );
            },
          );
        },
      )
    );
  }
}