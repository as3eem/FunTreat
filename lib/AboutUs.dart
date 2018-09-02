import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {


  _sendMail() async {
    // Android and iOS
    const uri = 'mailto:funtreat7518@gmail.com?subject=Funtreat Customer Query&body=Could I know ...';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    var device =MediaQuery.of(context).size;
    return new Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: new FloatingActionButton(
          onPressed: ()=>_sendMail(),
          tooltip: "Contact Us",
          child: new Icon(Icons.mail),
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
        body: new ListView(
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
                      child: new FadeInImage(
                        placeholder: new AssetImage('assets/download.png'),
                        image: new AssetImage('assets/wall.jpg'),
                        fit: BoxFit.cover,
                      ),
                      clipper: BottomWaveClipper(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        'FunTreat',
                        style: TextStyle(fontSize: 29.0, fontFamily: "Signika"),
                        maxLines: 1,
                      ),
                      new Padding(padding: EdgeInsets.only(top: 10.0)),
                      new Text(
                        "Hungry? Get the food you want, from the restaurants you love, delivered at your doorsteps.",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 10.0)),
                      new Text(
                        "Eat what you like, where you like, when you like. Find the local flavours you crave, all at the tap of a button.",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 10.0)),
                      new Text(
                        "Virtually go through local restaurants and fast food favourites for inspiration. Or get just what you\’re looking for, be it a specific restaurant, dish or cuisine. Pizza. Burritos. Burgers. Sushi. If you\'re hungry for it, try FunTreat.",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 10.0)),
                      new Text(
                        "When you’re ready to place your order, you’ll see your delivery address, an estimated delivery time and the total price including tax and booking fee. Pay only when you get tour food.",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 10.0)),
                      new Text(
                        "FunTreat chooses your local favourites; the best food near you. Chineese or Italian, healthy salads or food to nurse your hangover -- your food will be cooked with love and care. Our riders come to your very doorstep with a smile while you save time to do something else you love. There's a cuisine and a dish to suit every moment, and we'll help you make the first bite last.",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
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