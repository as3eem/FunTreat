import 'package:flutter/material.dart';
import 'package:ft/review.dart';
import 'package:ft/successfullyPlaced.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: new IconButton(
          onPressed: (){
            Navigator.pop(context,true);
          },
          icon: new Icon(Icons.keyboard_arrow_left, color: Colors.black,)
        ),
        elevation: 0.0,
        title: new Text("Address Confirmation", style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 26.0)),
      ),
      body: as3eem_address_template(),
    );
  }
}

class as3eem_address_template extends StatefulWidget {
  @override
  _as3eem_address_templateState createState() => _as3eem_address_templateState();
}

class _as3eem_address_templateState extends State<as3eem_address_template> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nm= new TextEditingController();
  final TextEditingController _ph= new TextEditingController();
  final TextEditingController _add= new TextEditingController();
  final TextEditingController _eml= new TextEditingController();
  var dt = new DateTime.now();
  String _email = '';
  String _name = '';
  String _phone = '';
  String _address = '';
  bool _autovalidate = false;
  @override
  void initState() {
    super.initState();
    getTestPrefs();
  }


  void _as3eem_save_address_prefs() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
    prefs.setString('address', _address);
    prefs.setString('phone', _phone);
    prefs.setString('email', _email);
  }




  getTestPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nm.text=prefs.getString("name");
      _eml.text=prefs.getString("email");
      _ph.text=prefs.getString("phone");
      _add.text=prefs.getString("address");
    });
  }

  void _submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _as3eem_save_address_prefs();
    }
    else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
  void _executeShopping() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => successfullyPlaced()));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Form(
        autovalidate: _autovalidate,
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                child: new TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (val) => _name=val,
                  controller: _nm,
                  validator: (val){
                    if (val.isEmpty){
                      return 'Enter your name';
                    }
                  },
                  decoration: new InputDecoration(labelText: "Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0))),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                child: new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: new Key('email'),
                  autocorrect: false,
                  controller: _eml,
                  onSaved: (val) => _email=val,
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')){
                      return 'Please enter Email in correct format.';
                    }
                  },
                  decoration: new InputDecoration(labelText: "Email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0))),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                child: new TextFormField(
                  key: new Key('phone'),
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  onSaved: (val) => _phone=val,
                  controller: _ph,
                  validator: (val) {
                    if (val.length != 10){
                      return "Enter 10 digits only";
                    }
                  },
                  decoration: new InputDecoration(labelText: "Mobile",border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0))),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                child: new TextFormField(
                  key: new Key('address'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  controller: _add,
                  onSaved: (val) => _address=val,
                  validator: (val) {
                    if (val.length < 5){
                      return "Provide appropriate address";
                    }
                  },
                  decoration: new InputDecoration(labelText: "Address",border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0))),
                ),
              ),
              new Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3,vertical: 10.0),
                    child: new RaisedButton(
                      onPressed: (){
                        setState(() {
                          _autovalidate=true;
                        });
                        _submit();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => review()));

                      },
                      child: new Text("Confirm",style: TextStyle(color: Colors.white, fontSize: 19.0),),
                      color: Colors.deepOrange,
                    ),
              )
            ],
          )
      )
    );
  }

}

