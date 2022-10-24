import 'package:driverassistant/listview.dart';
import 'package:flutter/material.dart';
class mainpview extends StatelessWidget {
  const mainpview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
      '/a':(ctx)=>listview()
    }
    ,
      home: Scaffold(
        body:
        Stack(
          children:[ Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('assets/drows.jpg'),
                      fit: BoxFit.cover))

          ),

            Builder(
              builder: (ctx)=>  Align(
                alignment: Alignment(0, 0.80),
                child: Container(
                  width: 250,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(ctx).pushNamed('/a');
                    },
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  ),
                ),
              ),
            )

          ]
        ),

      ),
    );
  }
}
