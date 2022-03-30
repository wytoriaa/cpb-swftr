import 'package:capybaflutter/controller/user-c.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
 
class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
 
  late final UserControl userController =
      Provider.of<UserControl>(context, listen: false);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (text) => email = text,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (text) => password = text,
              ),
              ElevatedButton(
                onPressed: () async {
                  await userController.login(email, password);
                },
                child: Text("Login"),
              ),
              Text("OU"),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ),
                  );
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
 