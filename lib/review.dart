import 'package:flutter/material.dart';
import 'package:ft/classes/cart_list.dart';
import 'package:ft/classes/plants_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft/splashConfirm.dart';
import 'dart:async';
import 'package:mailer/mailer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class review extends StatefulWidget {
  @override
  _reviewState createState() => _reviewState();
}

class _reviewState extends State<review> {
  var dt=DateTime.now();
  double as3eem = 0.0;
  int itemCount=0;
  var emailTemp="<head><style>table, th, td {border: 1px solid black;}</style></head><h1>Order confirmation from FunTreat</h1><br><h3>Hello there,</h3><br><h3>Order: </h3><br><table><tr><th>Food Item</th><th>Restaurant</th><th>Quantity</th><th>Price</th></tr>";


  var _nm,_em,_ph,_ad;
  _getTestPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nm=prefs.getString("name");
      _em=prefs.getString("email");
      _ph=prefs.getString("phone");
      _ad=prefs.getString("address");
    });
  }

  String setText(){
    for (int plantPos in CartList.cartItems) {
      emailTemp+="<tr><td>${plantsList[plantPos].plantName}</td><td>${plantsList[plantPos].plantImg}</td><td>${plantsList[plantPos].quantity}</td><td>₹${plantsList[plantPos].price * plantsList[plantPos].quantity}</td></tr>";
    }
    emailTemp+="</table><br><h3>Total: $as3eem</h3><br><h3>Delivery Address: </h3><b>$_ad</b><br><h3>Contact: </h3><b>$_ph</b><br><h3>Email: </h3><br><b>$_em</b><br><br>Order in favour: $_nm";

    return emailTemp;
  }


  void send(){
    print(setText());
    setState(() {
      sending=1;
    });
    var options = new GmailSmtpOptions()
      ..username = 'funtreat7518@gmail.com'
      ..password = 'rudra#2351';

    var emailTransport = new SmtpTransport(options);

    var envelope = new Envelope()
      ..from = 'funtreat7518@gmail.com'
      ..recipients.add(_em)
      ..recipients.add('aseem2707@gmail.com')
      ..bccRecipients.add('as3eem@gmail.com')
      ..subject = 'Order Confirmation from FunTreat'
      ..html = '$emailTemp';

    emailTransport.send(envelope)
        .then((envelope) => print("Sent"))
        .whenComplete((){
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          CartList.cartItems.clear();
          plantsList.clear();
          tempo.clear();
          tempo.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context) => splashConfirm()));

        })
        .catchError((e) => (){
          print('Error occurred: $e');
        });
  }



  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> couponList;
  final CollectionReference collectionReference = Firestore.instance.collection('Coupons');
  int sending=0;
  @override
  void initState() {
    super.initState();
//     firebase coupons fetch
      subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        couponList=datasnapshot.documents;
      });
    });
//    firebase coupon fetch complete
      for (int plantPos in CartList.cartItems) {
        setState(() {
          as3eem += (plantsList[plantPos].price *plantsList[plantPos].quantity);
          itemCount=CartList.cartItems.length+1;
        });
      }
//      get prefs here
  _getTestPrefs();
  }
  var _coupon=0;
  final GlobalKey<FormState> _Coupon_Code = GlobalKey<FormState>();
  final TextEditingController _couponText= new TextEditingController();
  var _autovalidate=false;
  var total='0';

  @override
  Widget build(BuildContext context) {
    return sending==0?new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.keyboard_arrow_left,color: Colors.black,), onPressed: (){Navigator.pop(context);}),
        title: Text("Review Order",style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 26.0)),
      ),
      body: new ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          itemCount: itemCount,
          itemBuilder: (_,int pos){
            if(pos<itemCount-1){
                return new ListTile(
                  title: Text("${plantsList[CartList.cartItems[pos]].plantName}"),
                  leading: new Text('${plantsList[CartList.cartItems[pos]].quantity} x '),
                  trailing: new Text("\$${plantsList[CartList.cartItems[pos]].price * plantsList[CartList.cartItems[pos]].quantity}"),
                );
            }
            else{
              return new Column(
                children: <Widget>[
                  new Divider(),
                  new ListTile(
                    title: new Text("Sub Total",style: TextStyle(fontWeight: FontWeight.bold),),
                    leading: new Icon(Icons.payment),
                    trailing: new Text("\₹${as3eem.toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  as3eem<300.00?
                  new ListTile(
                    leading: new Icon(Icons.motorcycle),
                    title: new Text("Delivery Charge",style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text("Your subtotal is less than ₹300.00"),
                    trailing: new Text("₹20.00"),
                  ):new Divider(),

                  _coupon==0?
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 8.0, 5.0, 10.0),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          child: new Form(
                            autovalidate: _autovalidate,
                            key: _Coupon_Code,
                            child: new TextFormField(
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              controller: _couponText,
                              onSaved: (val)=>null,
                              validator: (val) {
                                if (true){
                                  return "Not a valid coupon code";
                                }
                              },
                              decoration: new InputDecoration(
                                  labelText: "Coupon Code",
                                  icon: new Icon(Icons.whatshot)
                              ),
                            ),
                          ),
                        ),
                        new RaisedButton(
                          onPressed: (){
                              final form = _Coupon_Code.currentState;
                              form.save();
                              if (_couponText.text.length>0){
                                for(var item in couponList){
                                  if (item.data['code'] == _couponText.text){
                                    setState(() {
                                      _coupon=int.parse(item.data['value']);
                                    });
                                  };
                                }
                                if(_coupon==0){
                                  setState(() {
                                    _autovalidate=true;
                                  });
                                }
                              }
                            },
                          color: Colors.transparent,
                          child: new Text("Apply"),
                          elevation: 0.0,
                          splashColor: Colors.redAccent,
                        )
                      ],
                    ),
                  )
                      :new ListTile(
                    leading: new Icon(Icons.local_offer),
                    title: new Text("Coupon Code Applied",style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text("A total of ${_coupon}% discount has been offered."),
                    trailing: new Text("- ₹${(_coupon*as3eem/100).toStringAsFixed(0)}"),
                  ),


                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.attach_money),
                      title: new Text("Total",style: TextStyle(fontWeight: FontWeight.bold),),
                      trailing: as3eem>=300.00?Text("₹${(as3eem*(1-_coupon/100)).toStringAsFixed(0)}"):Text("₹${((as3eem+ 20.00)*(1-_coupon/100)).toStringAsFixed(0)}")
                  ),
                  new Divider(),

                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
                    child: new FloatingActionButton(
                        onPressed: (){
                          setState(() {
                            if (as3eem>30.00){
                              total=(as3eem*(1-_coupon/100)).toStringAsFixed(0);
                            }
                            else{
                              total=((as3eem+ 20.00)*(1-_coupon/100)).toStringAsFixed(0);
                            }
                          });
                          send();
                          },
                        backgroundColor: Colors.lightGreen,
                        tooltip: "A Short press would be enough!",
                        child: new Icon(FontAwesomeIcons.check),
                    ),
                  )
                ],
              );
            }
          }
      )
    )
        :new Center(child: new CircularProgressIndicator(strokeWidth: 52.0,),);
  }
}


class ProfileTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;
  ProfileTile({this.title, this.subtitle, this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
        ),
      ],
    );
  }
}