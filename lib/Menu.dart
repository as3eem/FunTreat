import 'package:flutter/material.dart';
import 'package:ft/Cart.dart';
import 'package:ft/wall_screen.dart';



class Menu extends StatelessWidget {
  final String imgPath;
  final String name;
  final String des;
  final String rate;
  final String time;


  Menu({Key key,this.name, this.imgPath, this.des, this.rate, this.time});

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return new Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: new FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          },
          child: new Icon(Icons.shopping_cart),
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 0.0),
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(0.0),
                  height: device.height *0.5 ,
                  width: device.width,
                  child: new ClipPath(
                    child: new ClipPath(
                      child: Image.network(imgPath,fit: BoxFit.cover,),
                      clipper: BottomWaveClipper(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(fontSize: 29.0, fontFamily: "Signika"),
                        maxLines: 1,
                      ),
                      new Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(
                        "$des",
                        style: TextStyle(fontSize: 14.0, color: Colors.grey, fontStyle: FontStyle.italic),

                      ),
                    ],
                  ),
                ),
                new Divider(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        child: new Row(
                          children:
                          List
                              .generate(int.parse(rate), (i) => new Icon(Icons.star,size: 18.0,color: 2<int.parse(rate)?Colors.redAccent:Colors.purple,))
                              .toList(),
                        )
                    ),
                    new Text("$time", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                  ],
                ),
                new Divider(),
                new Material(
                  child: new Container(height: MediaQuery.of(context).size.height * 0.72,child: WallScreen(name: name,),),
                  color: Colors.pinkAccent,
                )

              ],
            ),
          ],
        )
    );
  }
}




class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}