import 'package:flutter/material.dart';
import 'classes/plant.dart';
import 'classes/cart_list.dart';
import 'classes/plants_list.dart';


class CartItem extends StatefulWidget
{
  final int pos;
  final Plant plant;
  CartItem(this.pos,this.plant);

  @override
  CartItemState createState() {
    return new CartItemState();
  }
}

class CartItemState extends State<CartItem> {
  int _thisItem=1;
  @override
  Widget build(BuildContext context)
  {
    return new Dismissible(
      key: new Key("${widget.pos}"),
      onDismissed: (direction){
        for (int item=0; item<plantsList.length ;item++){
          if (plantsList[item].plantName == widget.plant.plantName){
            plantsList.removeAt(item);
            tempo.remove("${widget.plant.plantName + widget.plant.plantImg}");
          }
        }
        CartList.cartItems.removeLast();

        if (CartList.cartItems.length==0){
          Navigator.pop(context);
        }
      },
      child: new Container(
        margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: new Material(
          elevation: 30.0,
          shadowColor: Colors.black54,
          color: Colors.white,
          borderRadius: new BorderRadius.circular(6.0),
          child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 6.0),
            child: new ListTile(
              leading: new Column(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.add_circle, color: Colors.redAccent,),
                    onPressed: (){

                      setState(() {
                        widget.plant.quantity++;
                      });
                    },
                    padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 2.0),
                  ),

                  new Text("${widget.plant.quantity}"),

                  new IconButton(
                      icon: new Icon(Icons.remove_circle, color: Colors.redAccent),
                      onPressed: (){
                        setState(() {
                        widget.plant.quantity>1?widget.plant.quantity--:1;
                        });
                      },
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 20.0)
                  ),

                ],
              ),
              title: new Text(widget.plant.plantName, style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0)),
              subtitle: new Material(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(8.0),
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                          widget.plant.price - widget.plant.price.truncate() > 0
                              ? '\₹${widget.plant.price.toStringAsFixed(2)} x ${widget.plant.quantity}'
                              : '\₹${widget.plant.price.truncate()} x ${widget.plant.quantity}',
                          style: new TextStyle(color: Colors.grey)),
                      new Text(widget.plant.plantImg,style: new TextStyle(color: Colors.grey)),
                    ],
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}