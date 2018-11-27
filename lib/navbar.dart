import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'AboutUs.dart';
import 'list.dart';
class navbar extends StatefulWidget {

  final AnimationController controller;

  navbar({this.controller});

  @override
  _navbarState createState() => _navbarState();
}

class _navbarState extends State<navbar> {

  static const header_Height=42.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints){

    final height = constraints.biggest.height;
    final backPanelHeight = height-header_Height;
    final frontPanelHeight = -header_Height;

    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      ).animate(
          new CurvedAnimation(
            parent: widget.controller,
            curve: Curves.linear
        ));
  }
  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            color: theme.primaryColor,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: new CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 54.0,
                      child: new Icon(Icons.fastfood,size: 74.0,color: Colors.redAccent,),
                    ),
                  ),




                  new GestureDetector(
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                      },
                    child: new Container(
                      margin: new EdgeInsets.symmetric(horizontal: size.width * 0.10, vertical: 18.0),
                      child: new Material(
                        elevation: 30.0,
                        shadowColor: Colors.black54,
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(6.0),
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 6.0),
                          child: new ListTile(
                            leading: new Icon(Icons.people,color: Colors.redAccent,size: 34.0,),
                            title: new Text("About Us",textAlign: TextAlign.justify ,style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 21.0)),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              )
            ),
          ),

          new PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: new Material(
              elevation: 12.0,
              borderRadius: new BorderRadius.only(
                  topLeft: new Radius.circular(16.0),
                  topRight: new Radius.circular(16.0)),
              child: new Column(
                children: <Widget>[
                  new Container(
                    height: header_Height,
                    child: new Center(

                      child: new Text(
                        "Outlets",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: list()
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: bothPanels,
    );
  }
}