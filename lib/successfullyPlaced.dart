import 'dart:async';
import 'classes/plants_list.dart';
import 'package:flutter/material.dart';

class successfullyPlaced extends StatefulWidget {
  @override
  _successfullyPlacedState createState() => _successfullyPlacedState();
}

class _successfullyPlacedState extends State<successfullyPlaced> {
  bool isDataAvailable=false;
  var dt = new DateTime.now();

  // ignore: missing_return
  Widget showSuccessDialog() {
    setState(() {
      isDataAvailable = false;
      Future.delayed(Duration(seconds: 3)).then((_) => goToDialog());
    });
  }


  goToDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
              width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ProfileTile(
                          title: "Thank You!",
                          textColor: Colors.redAccent,
                          subtitle: "Your order has been successfully placed",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: List
                              .generate(50, (i) => "-")
                              .map((o) => Text(
                            o,
                            maxLines: 1,
                          ))
                              .toList(),
                        ),
                        ListTile(
                          title: Text("Date"),
                          subtitle: Text("${ dt.day} - ${ dt.month } - ${dt.year}"),
                          trailing: Text("${ dt.hour}:${ dt.minute } ${dt.hour>12?"PM":"AM" }"),
                        ),
                        ListTile(
                          title: Text("Pawan Kumar"),
                          subtitle: Text("mtechviral@gmail.com"),
                          trailing: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                                "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4"),
                          ),
                        ),
                        ListTile(
                          title: Text("Amount"),
                          subtitle: Text("\$299"),
                          trailing: Text("Completed"),
                        ),
                        Card(
                          elevation: 0.0,
                          color: Colors.grey.shade300,
                          child: ListTile(
                            leading: Icon(
                              Icons.credit_card,
                              color: Colors.blue,
                            ),
                            title: Text("Credit/Debit Card"),
                            subtitle: Text("Amex Card ending ***6"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }


  successTicket() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    child: Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ProfileTile(
              title: "Thank You!",
              textColor: Colors.redAccent,
              subtitle: "Your order has been successfully placed",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: List
                  .generate(50, (i) => "-")
                  .map((o) => Text(
                o,
                maxLines: 1,
              ))
                  .toList(),
            ),
            ListTile(
              title: Text("Date"),
              subtitle: Text("${ dt.day} - ${ dt.month } - ${dt.year}"),
              trailing: Text("${ dt.hour}:${ dt.minute } ${dt.hour>12?"PM":"AM" }"),
            ),
            ListTile(
              title: Text("Pawan Kumar"),
              subtitle: Text("mtechviral@gmail.com"),
              trailing: CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4"),
              ),
            ),
            ListTile(
              title: Text("Amount"),
              subtitle: Text("\$299"),
              trailing: Text("Completed"),
            ),
            Card(
              elevation: 0.0,
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(
                  Icons.credit_card,
                  color: Colors.blue,
                ),
                title: Text("Credit/Debit Card"),
                subtitle: Text("Amex Card ending ***6"),
              ),
            )
          ],
        ),
      ),
    ),
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: new Text("Order Status",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: showSuccessDialog(),
      backgroundColor: Colors.white,
    );
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