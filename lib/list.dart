import 'package:flutter/material.dart';
import 'Cart.dart';
import 'Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class list extends StatefulWidget {
  @override
  _listState createState() => _listState();
}

class _listState extends State<list> {

  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> restaurantList;
  final CollectionReference collectionReference = Firestore.instance.collection('Restaurants');

  @override
  void initState() {
    super.initState();
    subscription=collectionReference.snapshots().listen((datasnapshot){

      setState(() {
        restaurantList=datasnapshot.documents;
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
    var deviceSize = MediaQuery.of(context).size;
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          print("as3eem pushed this to cart");
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));

        },
        child: new Icon(Icons.shopping_cart),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
      body: restaurantList!=null?
      new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: restaurantList.length,
              itemBuilder: (context, index){
              String name = restaurantList[index].data['name'];
              String des = restaurantList[index].data['des'];
              String rate = restaurantList[index].data['rate'];
              String time= restaurantList[index].data['time'];
              String address= restaurantList[index].data['address'];
              String imgPath= restaurantList[index].data['image'];
              return new Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Divider(height: 20.0,),
                      new ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Menu(name: name, imgPath: imgPath, des: des, rate: rate, time: time)));
                        },
                        leading: CircleAvatar(
                          radius: 24.0,
                          foregroundColor: Theme.of(context).primaryColor,
                          backgroundImage: new NetworkImage(imgPath),
                        ),
                        title: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(name, style: TextStyle(fontFamily: "Signika", fontWeight: FontWeight.bold)),
                            new Text(time, style: TextStyle(fontSize: 14.0, color: Colors.grey),)
                          ],
                        ),
                        subtitle: new Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: new Text(address,style: TextStyle(color: Colors.grey, fontSize: 15.0),),
                        ),
                      ),


                    ]
                );
            }
          )),
        ],
      ):new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }
}

