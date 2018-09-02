import 'package:flutter/material.dart';
import 'package:ft/BackDropPage.dart';
import 'package:ft/noInternet.dart';
import 'dart:async';
import 'classes/shared_prefs_list.dart';
import 'classes/sharedPrefs.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      BackDropPage.routeName: (BuildContext context) => new BackDropPage(),
    };
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      theme: new ThemeData(
        primarySwatch: Colors.red,
        primaryTextTheme: TextTheme(title: TextStyle(fontFamily: 'Signika'), caption: TextStyle(fontFamily: 'Signika'))
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs
        .getString('name')
        .isNotEmpty) {

      sharedPrefsList.prefItems.add(sharedPrefs(await prefs.getString('name'), await prefs.getString('phone'), await prefs.getString('address'), await prefs.getString('email')));
    }
  }
  var connected=0;
   _checkInternet() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          connected=1;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
        return '0';
    }
  }
  @override
  void initState() {
    super.initState();
    _checkInternet();

    Timer(Duration(seconds: 4),(){
      if(connected==1){
        getPrefs();
        Navigator.pop(context);
        Navigator.pushNamed(context, BackDropPage.routeName);
      }
      else{
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => noInternet()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 65.0,
                        child: Icon(
                          Icons.fastfood,
                          size: 80.0,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text("FunTreat",style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(size.width * 0.25,0.0,size.width * 0.25,0.0),
                      child: LinearProgressIndicator(backgroundColor: Colors.white),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Text("Loading lots of fatty food",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0
                    ),)
                  ],
                ),
              )
            ],
          ),
        ]));
  }
}