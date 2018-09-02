import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(signin());


class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  String mytext=null;
  final DocumentReference documentReference = Firestore.instance.document("myData/dummy");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.idToken);
    print("USer NAME: ${user.displayName}");
    return user;
  }

  void _signOut(){
    googleSignIn.signOut();
    print("User Signed Out");
  }

  void _add(){
    print("entered");
    Map<String,String> data = <String,String>{
      "name": "Aseem Srivastava",
       "description" : "Flutter Deveop"
    };
    documentReference.setData(data).whenComplete((){
      print("document added");
    }).catchError((e)=>print(e));
  }

  void _delete(){
    documentReference.delete().whenComplete((){
      print("deleted Successfully");
      setState(() {
        
      });
    }).catchError((e)=>print(e));
  }

  void _update(){
    Map<String,String> data = <String,String>{
      "name": "Aseem Khureshi",
      "description" : "Flutter Deveop"
    };
    documentReference.updateData(data).whenComplete((){
      print("document added");
    }).catchError((e)=>print(e));

  }

  void _fetch(){
    documentReference.get().then((datasnapshot){
      if (datasnapshot.exists){
        setState(() {
          mytext=datasnapshot.data['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: new Padding(
          padding: EdgeInsets.all(10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new RaisedButton(
                child: new Text("Sign In"),
                color: Colors.green,
                onPressed: (){
                  _signIn()
                      .then((FirebaseUser user)=>print(user))
                      .catchError((e)=>print(e));
                },
              ),
              new Divider(),
              new RaisedButton(
                child: new Text("Sign Out"),
                color: Colors.green,
                onPressed: (){
                  _signOut();
                },
              ),
              new Divider(),
              new RaisedButton(
                child: new Text("Add"),
                color: Colors.green,
                onPressed: (){_add();},
              ),
              new Divider(),
              new RaisedButton(
                child: new Text("Update"),
                color: Colors.green,
                onPressed: (){
                  _update();
                },
              ),
              new Divider(),
              new RaisedButton(
                  onPressed: _delete,
                  color: Colors.redAccent,
                child: new Text("Delete"),
              ),
              new Divider(),
              new RaisedButton(
                onPressed: _fetch,
                color: Colors.redAccent,
                child: new Text("Fetch"),
              ),
              new Divider(),
              mytext==null?new Container():new Text(mytext, style: TextStyle(fontSize: 10.0 ),)
            ],
          )
      ),
    );
  }
}


