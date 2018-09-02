import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ft/navbar.dart';



class BackDropPage extends StatefulWidget {
  static const String routeName = "/BackDropPage";
  @override
  _BackDropPageState createState() => _BackDropPageState();
}

class _BackDropPageState extends State<BackDropPage> with SingleTickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(vsync: this, duration: new Duration(milliseconds: 100),value: 1.0);
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool get isPanelVisible{
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed || status== AnimationStatus.forward;
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new WillPopScope(
      onWillPop: quitApp,
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          leading: new IconButton(
            icon: new AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: controller.view
            ),
            onPressed: (){
              controller.fling(
                  velocity: isPanelVisible?-1.0:1.0
              );
            },
          ),
          title: new Text("Funtreat"),
        ),
        body: navbar(
          controller: controller,
        ),
      ),
    );
  }

  Future<bool> quitApp() async{
    exit(0);
    return true;
  }
}


