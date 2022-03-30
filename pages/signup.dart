import 'package:capybaflutter/controller/user-c.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name = "";
  String email = "";
  String password = "";

  late final userController = Provider.of<UserControl>(context, listen: false);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (text) => name = text,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                onChanged: (text) => email = text,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                onChanged: (text) => password = text,
              ),
              ElevatedButton(
                onPressed: () async {
                  /// Informações que vão para o firebase
                  try{
                    final user = UserInfo(name);
                    await userController.singup(email, password, user);

                    Navigator.pop(context);
                  } on FirebaseAuth catch (w) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  
                },
                child: Text("Create Account"),
              )
            ],
          ),
          
        ),
      ),
    );
  }
}