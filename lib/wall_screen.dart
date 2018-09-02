import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'classes/cart_list.dart';
import 'classes/plants_list.dart';
import 'classes/plant.dart';
import 'dart:math';

class WallScreen extends StatefulWidget {
  WallScreen({
    Key key,
    this.name,
}):super(key: key);
  String name;
  @override
  _WallScreenState createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> wallpapersList;


  @override
  void initState() {
    super.initState();
    var
    subscription=Firestore.instance.collection('${widget.name}').snapshots().listen((datasnapshot){
      setState(() {
        wallpapersList=datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String resta=(widget.name);
    return Scaffold(
      body: wallpapersList!=null?
      new StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 4,
        itemCount: wallpapersList.length,
        itemBuilder: (context,i){
          String imgPath = wallpapersList[i].data['url'];
          String foodName = wallpapersList[i].data['name'];
          String price = wallpapersList[i].data['price'];
          return new Material(
            elevation: 8.0,
            borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
            child: new InkWell(
              onTap: ()=>buyFood(foodName,price,resta),
              child: new Hero(
                tag: imgPath,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new FadeInImage(
                      placeholder: new AssetImage('assets/download.png'),
                      image: new NetworkImage(imgPath),
                      fit: BoxFit.cover,
                    ),
                    new Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: 32.0,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(foodName),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text("Rs. "+price, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (i)=>new StaggeredTile.count(2,i.isEven?2:3),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ):new Center(
        child: new CircularProgressIndicator(),
      )
    );
  }

  void buyFood(foodName,price,resta){
    final snackBar = SnackBar(
      content: Text(foodName+' Item added to the cart'),
      backgroundColor: Colors.redAccent,
      duration: Duration(milliseconds: 600),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    if (tempo.length>0 && tempo.contains("${foodName+resta}")){
      print("already in ASEEM's CART");
    }
    else{
      tempo.add(foodName+resta);
      setState(() {
        plantsList.add(new Plant(foodName, double.parse(price), resta,1));
      if(CartList.cartItems.length>0) CartList.cartItems.add(CartList.cartItems.reduce(max) + 1);
      else CartList.cartItems.add(0);
      });
    }
  }
}








