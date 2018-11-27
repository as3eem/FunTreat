import 'package:flutter/material.dart';
import 'Address.dart';
import 'classes/cart_list.dart';
import 'classes/plants_list.dart';
import 'cart_item.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = '';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}


class _CartState extends State<Cart> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(CartList.cartItems.length > 0) {
      return new Material(
        borderRadius: new BorderRadius.circular(8.0),
        child: new Scaffold(
          appBar: new AppBar(
            leading: new IconButton(icon: new Icon(Icons.keyboard_arrow_left, color: Colors.black,),onPressed: ()=>Navigator.pop(context),),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: new Text('Cart', style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 26.0)),
          ),
          backgroundColor: Colors.white,
          body: new ListView.builder(
            itemCount: CartList.cartItems.length,
            itemBuilder: (_, int pos) => new CartItem(pos,plantsList[CartList.cartItems[pos]]),
          ),
          bottomNavigationBar: new Hero(
            tag: 'Buy button',
            child: new MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Address()));
              },
                color: Colors.redAccent,
                splashColor: Colors.lime,
                child: new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new Text('Place Order ', style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      );
    }

    else {
      return new Material(
        borderRadius: new BorderRadius.circular(8.0),
        child: new Scaffold(
            appBar: new AppBar(
              leading: new IconButton(icon: new Icon(Icons.keyboard_arrow_left, color: Colors.black,),onPressed: ()=>Navigator.pop(context),),
              backgroundColor: Colors.white,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: new Text('Review Order', style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 26.0)),
            ),
            backgroundColor: Colors.white,
            body: new Center
              (
              child: new Column
                (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  new Icon(Icons.remove_shopping_cart, color: Colors.black26, size: 96.0),
                  new Padding(padding: new EdgeInsets.only(bottom: 48.0)),
                  new Text('Your cart is empty!', style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 28.0)),
                  new Padding(padding: new EdgeInsets.only(bottom: 8.0)),
                  new Container
                    (
                    margin: new EdgeInsets.symmetric(horizontal: 64.0),
                    child: new Text('Looks like you haven\'t added any food item to your cart yet.', textAlign: TextAlign.center, style: new TextStyle(fontSize: 20.0)),
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
                        onTap: () => Navigator.of(context).pop(),
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

  double calculateFinalPrice()
  {
    double as3eem = 0.0;
    for (int plantPos in CartList.cartItems)
    {
//      (\₹${calculateFinalPrice().toStringAsFixed(2)})
      setState(() {
        as3eem += (plantsList[plantPos].price *plantsList[plantPos].quantity);
      });
    }

    return as3eem;
  }
}