// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capybaflutter/models/user.dart';

enum AuthState {signed, unsigned, loading} //aqui dentro teremos criaremos constantes

class UserControl extends ChangeNotifier{
  //fazendo a estruturação para receber as informações do firebase
  AuthState authState = AuthState.loading;
  //o underline(_) serve para deixar ele inacessível fora da classe 
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late UserInfo model;
  User? get user => _auth.currentUser; //se ? for nulo, o usuario nao está logado

UserControl(){
  _auth.authStateChanges().listen((user) async {
       //se o usuario nao for nulo, irá fazer login e entrara nessa condição
      if(user!= null){
        authState = AuthState.signed; 
        final doc = await _db.collection('users').doc(user.uid).get();
        model = UserInfo.fromMap(doc.data()!);
      }else{
        authState = AuthState.unsigned;
      }
      notifyListeners();
  });
}
  //o await funciona com o async
  //funcao para o usuario fazer login
  Future<void> login(String email, String password) async{
    await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  //funcao para deslogar o usuario
  Future<void> logout() async{
    await _auth.signOut();
  }

  //funcao para criar cadastro
  Future <void> singup(
    String email,
    String password,
    UserInfo payload
  ) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    final uid = cred.user?.uid;
    final data = payload.toMap();
    data['key'] = uid;

    final dc = _db.collection('users').doc(uid);
    await dc.set(data); //vai receber os dados e levar ate a colecao criada no firebase
  }
}