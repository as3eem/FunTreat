import 'dart:io';

import 'package:flutter/material.dart';

class noInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      borderRadius: new BorderRadius.circular(8.0),
      child: new Scaffold(
          backgroundColor: Colors.white,
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.signal_wifi_off, color: Colors.black26, size: 96.0),
                new Padding(padding: new EdgeInsets.only(bottom: 48.0)),
                new Text('Oooops!', style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 28.0)),
                new Padding(padding: new EdgeInsets.only(bottom: 8.0)),
                new Container
                  (
                  margin: new EdgeInsets.symmetric(horizontal: 64.0),
                  child: new Text('Looks like you don\'t have internet connection.', textAlign: TextAlign.center, style: new TextStyle(fontSize: 20.0)),
                ),
                new Padding(padding: new EdgeInsets.only(bottom: 96.0)),
                new Container
                  (
                  child: new Material
                    (
                    elevation: 16.0,
                    shadowColor: new Color.fromRGBO(255, 102, 102, 5.0),
                    color: Colors.white,
                    child: new InkWell
                      (
                      onTap: () => exit(0),
                      child: new Padding
                        (
                        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
                        child: new Text('Go back', style: new TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
