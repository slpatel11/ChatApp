//import 'dart:html';

import 'package:chatapp/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserAuthScreen extends StatefulWidget {
  const UserAuthScreen({Key? key}) : super(key: key);

  @override
  State<UserAuthScreen> createState() => _UserAuthScreenState();
}

class _UserAuthScreenState extends State<UserAuthScreen> {
  final _auth = FirebaseAuth.instance;

  Future<void> _submitAuthForm(
      String email, String pwd, String username, bool isLogin,BuildContext ctx) async {
    UserCredential _authResult;
    try {
      if (isLogin) {
        _authResult =
            await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: pwd);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authResult.user?.uid)
            .set({'userName': username, 'email': email});
      }
    } on PlatformException catch (err) {
      String? msg = 'An error occurred please check your credentials';
      if (err.message != null) {
        msg = err.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg!),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }catch(err){
      print(err.toString());
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
