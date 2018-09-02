import 'package:flutter/material.dart';
import 'dart:async';
class splashConfirm extends StatefulWidget {
  @override
  _splashConfirmState createState() => _splashConfirmState();
}

class _splashConfirmState extends State<splashConfirm> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
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
                          Icons.done_all,
                          size: 80.0,
                          color: Colors.teal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
//                      Text("Order Confirmed",style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 34.0,
//                        fontWeight: FontWeight.bold,
//                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(size.width * 0.25,0.0,size.width * 0.25,0.0),
//                      child: LinearProgressIndicator(backgroundColor: Colors.white),
//                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Text("Order Confirmed",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 19.0
                    ),)
                  ],
                ),
              )
            ],
          ),
        ]));





  }
}
